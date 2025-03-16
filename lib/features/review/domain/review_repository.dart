abstract class ReviewRepository {
  const ReviewRepository();

  Future<void> incrementLaunches();

  Future<void> showReviewPrompt();

  Future<void> checkAndShowReviewPrompt();
}
