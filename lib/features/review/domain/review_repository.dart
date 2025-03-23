import 'package:flutter/widgets.dart';

abstract class ReviewRepository {
  const ReviewRepository();

  Future<void> incrementLaunches();

  Future<void> showReviewPrompt(BuildContext context);

  Future<void> checkAndShowReviewPrompt(BuildContext context);
}
