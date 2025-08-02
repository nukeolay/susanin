import 'package:share_plus/share_plus.dart';

extension ShareExtension on SharePlus {
  Future<void> shareLocation({
    required String name,
    required double latitude,
    required double longitude,
  }) async {
    final shareLink =
        '$name https://www.google.com/maps/search/?api=1&query='
        '$latitude,$longitude';
    await SharePlus.instance.share(ShareParams(text: shareLink));
  }
}
