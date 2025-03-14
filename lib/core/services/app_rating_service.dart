import 'package:in_app_review/in_app_review.dart';
import 'package:advanced_in_app_review/advanced_in_app_review.dart';

ReviewService globalReviewService = ReviewService();

class InAppReviewServiceWrapper {
  final inAppReview = InAppReview.instance;

  Future<bool> isAvailable() async {
    return inAppReview.isAvailable();
  }

  void showRatingDialogIfMeetsConditions() {
    AdvancedInAppReview() //R
        .setMinDaysAfterInstall(0)
        .setMinDaysBeforeRemind(0)
        .setMinLaunchTimes(0)
        .setMinSecondsBeforeShowDialog(3)
        .monitor();
  }

  Future<void> openStoreListing() async {
    inAppReview.openStoreListing();
  }
}

class ReviewService {
  final InAppReviewServiceWrapper wrapper;

  ReviewService({
    InAppReviewServiceWrapper? wrapper,
  }) : wrapper = wrapper ?? InAppReviewServiceWrapper();

  Future<bool> isAvailable() async {
    return wrapper.isAvailable();
  }

  Future<void> showRatingDialogIfMeetsConditions() async {
    if (await isAvailable()) {
      wrapper.showRatingDialogIfMeetsConditions();
    }
  }

  Future<void> openStoreListing() async {
    wrapper.openStoreListing();
  }
}
