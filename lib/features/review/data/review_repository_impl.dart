import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/local_storage.dart';
import '../domain/review_repository.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  ReviewRepositoryImpl({
    required LocalStorage localStrorage,
    required String androidAppId,
    required String iosAppId,
    required VoidCallback onError,
    int launchesThreshold = 3,
    int daysBetweenPrompts = 7,
  }) : _localStorage = localStrorage,
       _androidAppId = androidAppId,
       _iosAppId = iosAppId,
       _onError = onError,
       _inAppReview = InAppReview.instance,
       _launchesThreshold = launchesThreshold,
       _daysBetweenPrompts = daysBetweenPrompts;

  final LocalStorage _localStorage;
  final InAppReview _inAppReview;
  final VoidCallback _onError;

  static const String _launchesKey = 'launches';
  static const String _lastPromptedKey = 'lastPrompted';
  final int _launchesThreshold;
  final int _daysBetweenPrompts;
  final String _androidAppId;
  final String _iosAppId;

  @override
  Future<void> incrementLaunches() async {
    final launchCount = await _getLaunchCount();
    await _localStorage.save(
      key: _launchesKey,
      data: (launchCount + 1).toString(),
    );
  }

  @override
  Future<void> showReviewPrompt() => _showReviewPrompt();

  @override
  Future<void> checkAndShowReviewPrompt() async {
    final launchCount = await _getLaunchCount();
    final lastPromptedDate = await _getLastPromptedDate();
    final now = DateTime.now();
    if (launchCount >= _launchesThreshold &&
        (now.difference(lastPromptedDate).inDays >= _daysBetweenPrompts)) {
      await _savePromptedDate();
      await _showReviewPrompt();
    }
  }

  Future<void> _showReviewPrompt() async {
    final isAvailable = await _inAppReview.isAvailable();
    if (!isAvailable) return;
    try {
      await _inAppReview.requestReview();
    } catch (_) {
      await _openStore();
    }
  }

  Future<void> _savePromptedDate() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _localStorage.save(key: _lastPromptedKey, data: now.toString());
  }

  Future<void> _openStore() async {
    String url;
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/details?id=$_androidAppId';
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/app/id$_iosAppId';
    } else {
      _onError();
      return;
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _onError();
    }
  }

  Future<int> _getLaunchCount() async {
    final loadedValue = await _localStorage.load(key: _launchesKey);
    return int.tryParse(loadedValue ?? '0') ?? 0;
  }

  Future<DateTime> _getLastPromptedDate() async {
    final loadedValue = await _localStorage.load(key: _lastPromptedKey);
    final millisecondsSinceEpoch = int.tryParse(loadedValue ?? '0') ?? 0;
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }
}
