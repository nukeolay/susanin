import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/services/local_storage.dart';
import '../../../presentation/common/susanin_dialog.dart';
import '../domain/review_repository.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  ReviewRepositoryImpl({
    required LocalStorage localStrorage,
    required String androidAppId,
    required String iosAppId,
    int launchesThreshold = 3,
    int daysBetweenPrompts = 7,
  }) : _localStorage = localStrorage,
       _androidAppId = androidAppId,
       _iosAppId = iosAppId,
       _inAppReview = InAppReview.instance,
       _launchesThreshold = launchesThreshold,
       _daysBetweenPrompts = daysBetweenPrompts;

  final LocalStorage _localStorage;
  final InAppReview _inAppReview;

  static const _launchesKey = 'launches';
  static const _lastPromptedKey = 'lastPrompted';
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
  Future<void> showReviewPrompt(BuildContext context) =>
      _showReviewPrompt(context);

  @override
  Future<void> checkAndShowReviewPrompt(BuildContext context) async {
    final launchCount = await _getLaunchCount();
    final lastPromptedDate = await _getLastPromptedDate();
    final now = DateTime.now();
    final countCondition = launchCount >= _launchesThreshold;
    final daysCondition =
        now.difference(lastPromptedDate).inDays >= _daysBetweenPrompts;
    if (countCondition && daysCondition) {
      await _savePromptedDate();
      await _showReviewPrompt(context);
    }
  }

  Future<void> _showReviewPrompt(BuildContext context) async {
    final isAvailable = await _inAppReview.isAvailable();
    if (!isAvailable) return;
    try {
      await _inAppReview.requestReview();
    } catch (_) {
      final openStore = await _showReviewDialog(context);
      if (!openStore) return;
      await _openStore();
    }
  }

  Future<void> _savePromptedDate() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _localStorage.save(key: _lastPromptedKey, data: now.toString());
  }

  Future<bool> _showReviewDialog(BuildContext context) async {
    final result =
        await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return Material(
              type: MaterialType.transparency,
              shadowColor: Colors.transparent,
              child: SusaninDialog(
                text: context.s.review_dialog_title,
                secondaryButtonLabel: context.s.button_yes,
                onSecondaryTap: () => Navigator.pop(context, true),
                primaryButtonLabel: context.s.button_no,
                onPrimaryTap: () => Navigator.pop(context, false),
              ),
            );
          },
        ) ??
        false;
    return result;
  }

  Future<void> _openStore() async {
    String url;
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/details?id=$_androidAppId';
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/app/id$_iosAppId';
    } else {
      return;
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
