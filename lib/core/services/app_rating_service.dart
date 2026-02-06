import 'package:flutter/material.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/services/shared_preferences_service.dart';
import 'package:in_app_review/in_app_review.dart';

ReviewService globalReviewService = ReviewService();

class InAppReviewServiceWrapper {
  final inAppReview = InAppReview.instance;

  Future<bool> isAvailable() async {
    return inAppReview.isAvailable();
  }

  Future<void> openStoreListing() async {
    inAppReview.openStoreListing();
  }
}

class ReviewService {
  final InAppReviewServiceWrapper wrapper;
  bool isReviewed = SharedPreferencesService.getBool(isReviewedKey) ?? //R
      false;

  ReviewService({
    InAppReviewServiceWrapper? wrapper,
  }) : wrapper = wrapper ?? InAppReviewServiceWrapper();

  Future<bool> isAvailable() async {
    final result = await wrapper.isAvailable();
    globalLogger.log('ReviewService isAvailable = $result');
    return result;
  }

  Future<void> openStoreListing() async {
    await SharedPreferencesService.setBool('is_reviewed', true);
    await wrapper.openStoreListing();
  }

  static const String isReviewedKey = 'is_reviewed';
  static const String installDateKey = 'install_date';
  static const String lastPromptDateKey = 'last_prompt_date';
  static const String launchCountKey = 'launch_count';
  static const String actionCountKey = 'action_count';

  final int minDaysAfterInstall = 3;
  final int minDaysBeforeRemind = 3;
  final int minLaunchTimes = 5;
  final int minActionTimes = 8;
  final int minSecondsBeforeShowDialog = 3;

  Future<void> increaseLaunchCount() async {
    final int launchCount = SharedPreferencesService.getInt(launchCountKey) ?? 0;
    SharedPreferencesService.setInt(launchCountKey, launchCount + 1);
  }

  Future<void> monitor(BuildContext context) async {
    if (!isReviewed) {
      final int? installDate = SharedPreferencesService.getInt(installDateKey);
      final int? lastPromptDate = SharedPreferencesService.getInt(lastPromptDateKey);
      final int launchCount = (SharedPreferencesService.getInt(launchCountKey) ?? 0);
      final int actionCount = (SharedPreferencesService.getInt(actionCountKey) ?? 0) + 1;

      final int currentDate = DateTime.now().millisecondsSinceEpoch;

      if (installDate == null) {
        await SharedPreferencesService.setInt(installDateKey, currentDate);
        await SharedPreferencesService.setInt(launchCountKey, 1);
        return;
      }

      await SharedPreferencesService.setInt(actionCountKey, actionCount);

      if (shouldShowReview(
        installDate,
        lastPromptDate,
        launchCount,
        actionCount,
      )) {
        await Future.delayed(Duration(seconds: minSecondsBeforeShowDialog));
        if (context.mounted) {
          showReviewDialog(context);
        }
      }
    }
  }

  bool shouldShowReview(
    int installDate,
    int? lastPromptDate,
    int launchCount,
    int actionCount,
  ) {
    final DateTime now = DateTime.now();
    final DateTime installDateTime = DateTime.fromMillisecondsSinceEpoch(installDate);
    final DateTime? lastPromptDateTime = lastPromptDate != null //R
        ? DateTime.fromMillisecondsSinceEpoch(lastPromptDate)
        : null;

    final bool meetsInstallDays = now.difference(installDateTime).inDays >= minDaysAfterInstall;
    final bool meetsLaunchCount = launchCount >= minLaunchTimes;
    final bool meetsActionCount = actionCount >= minActionTimes;
    final bool meetsRemindDays = lastPromptDateTime == null || //R
        now.difference(lastPromptDateTime).inDays >= minDaysBeforeRemind;

    return meetsInstallDays && meetsLaunchCount && meetsActionCount && meetsRemindDays;
  }

  void showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) async {
            final int currentDate = DateTime.now().millisecondsSinceEpoch;
            await SharedPreferencesService.setInt('last_prompt_date', currentDate);
          },
          child: Dialog(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enjoying Quoteput?',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Rating the app really helps!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.primary.withValues(alpha: .2),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        await globalReviewService.openStoreListing();
                      },
                      child: Text(
                        'Rate Quoteput now!',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Remind Me Later',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: .5),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
