import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/services/app_rating_service.dart';
import 'package:random_quote_app/core/services/shared_preferences_service.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockInAppReviewServiceWrapper extends Mock implements InAppReviewServiceWrapper {}

class MockReviewService extends Mock implements ReviewService {}

class MockSharedPreferencesService extends Mock implements SharedPreferencesService {}

class MockBuildContext extends Mock implements BuildContext {}

class MockLogger extends Mock implements Logger {}

class MockSharedPreferencesWithCache extends Mock implements SharedPreferencesWithCache {}

void main() {
  late MockInAppReviewServiceWrapper mockReviewWrapper;
  late ReviewService reviewService;
  late MockSharedPreferencesWithCache mockPrefs;
  late MockBuildContext mockBuildContext;
  late MockLogger mockLogger;

  setUp(
    () async {
      mockPrefs = MockSharedPreferencesWithCache();
      await SharedPreferencesService.init(p: mockPrefs);
      mockReviewWrapper = MockInAppReviewServiceWrapper();
      reviewService = ReviewService(wrapper: mockReviewWrapper);
      globalReviewService = reviewService;
      mockBuildContext = MockBuildContext();
      mockLogger = MockLogger();
      globalLogger = mockLogger;
    },
  );

  tearDown(
    () {
      SharedPreferencesService.isInitialized = false;
    },
  );

  group(
    'isAvailable',
    () {
      test(
        'calls the check if review is available',
        () async {
          when(() => mockReviewWrapper.isAvailable()).thenAnswer((_) async => true);

          final result = await reviewService.isAvailable();

          expect(result, true);
          verify(() => mockReviewWrapper.isAvailable()).called(1);
        },
      );
    },
  );

  group(
    'openStoreListing',
    () {
      test(
        'calls service method for opening store listing',
        () async {
          when(() => mockReviewWrapper.openStoreListing()).thenAnswer((_) async {});

          await reviewService.openStoreListing();

          verify(() => mockReviewWrapper.openStoreListing()).called(1);
        },
      );
    },
  );

  group(
    'increaseLaunchCount',
    () {
      test(
        'sets launch count increased by one from the one gotten before',
        () async {
          when(() => mockPrefs.setInt(any(), any())).thenAnswer((_) async {});
          when(() => mockPrefs.getInt(ReviewService.launchCountKey)).thenReturn(3);

          await reviewService.increaseLaunchCount();

          verify(() => mockPrefs.setInt(ReviewService.launchCountKey, 4)).called(1);
        },
      );
    },
  );

  group(
    'monitor',
    () {
      testWidgets(
        'does not display review dialog if install date and remind date are under the specified count',
        (tester) async {
          when(() => mockPrefs.getInt(ReviewService.installDateKey)).thenReturn(
            DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
          );
          when(() => mockPrefs.getInt(ReviewService.launchCountKey)).thenReturn(3);
          when(() => mockPrefs.getInt(ReviewService.lastPromptDateKey)).thenReturn(
            DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
          );
          when(() => mockPrefs.setInt(any(), any())).thenAnswer((_) async {});
          when(() => mockBuildContext.mounted).thenAnswer((_) => true);

          await tester.pumpWidget(
            MaterialApp(
              home: Builder(
                builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      reviewService.monitor(context);
                    },
                  );
                  return Container();
                },
              ),
            ),
          );

          await tester.pumpAndSettle(Duration(seconds: 3));

          expect(find.byType(Dialog), findsNothing);
        },
      );

      testWidgets(
        'does not display review dialog if install date is null',
        (tester) async {
          when(() => mockPrefs.getInt(ReviewService.installDateKey)).thenReturn(
            null,
          );
          when(() => mockPrefs.getInt(ReviewService.launchCountKey)).thenReturn(3);
          when(() => mockPrefs.getInt(ReviewService.lastPromptDateKey)).thenReturn(null);
          when(() => mockPrefs.setInt(any(), any())).thenAnswer((_) async {});
          when(() => mockBuildContext.mounted).thenAnswer((_) => true);

          await tester.pumpWidget(
            MaterialApp(
              home: Builder(
                builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      reviewService.monitor(context);
                    },
                  );
                  return Container();
                },
              ),
            ),
          );

          await tester.pumpAndSettle(Duration(seconds: 3));

          expect(find.byType(Dialog), findsNothing);
        },
      );

      testWidgets(
        'displays review dialog when conditions are met',
        (tester) async {
          when(() => mockPrefs.getInt(ReviewService.installDateKey)).thenReturn(
            DateTime.now().subtract(Duration(days: 5)).millisecondsSinceEpoch,
          );
          when(() => mockPrefs.getInt(ReviewService.launchCountKey)).thenReturn(6);
          when(() => mockPrefs.getInt(ReviewService.actionCountKey)).thenReturn(10);
          when(() => mockPrefs.getInt(ReviewService.lastPromptDateKey)).thenReturn(
            DateTime.now().subtract(Duration(days: 5)).millisecondsSinceEpoch,
          );
          when(() => mockPrefs.setInt(any(), any())).thenAnswer((_) async => {});
          when(() => mockReviewWrapper.isAvailable()).thenAnswer((_) async => true);
          when(() => mockReviewWrapper.openStoreListing()).thenAnswer((_) async {});
          when(() => mockBuildContext.mounted).thenAnswer((_) => true);

          await tester.pumpWidget(
            MaterialApp(
              home: Builder(
                builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      reviewService.monitor(context);
                    },
                  );
                  return Container();
                },
              ),
            ),
          );

          await tester.pumpAndSettle(Duration(seconds: 3));

          expect(find.byType(Dialog), findsOneWidget);
        },
      );
    },
  );

  group(
    'showReviewDialog',
    () {
      testWidgets(
        'sets is_reviewed to true and calls openStoreListing on tap on review button',
        (tester) async {
          when(() => mockPrefs.setBool(any(), any())).thenAnswer((_) async {});
          when(() => mockPrefs.setInt(any(), any())).thenAnswer((_) async {});
          when(() => mockReviewWrapper.openStoreListing()).thenAnswer((_) async {});

          await tester.pumpWidget(
            MaterialApp(
              home: Builder(
                builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      reviewService.showReviewDialog(context);
                    },
                  );
                  return Container();
                },
              ),
            ),
          );

          await tester.pumpAndSettle(Duration(seconds: 3));
          final finder = find.text('Rate Quoteput now!');
          await tester.tap(finder);

          verify(
            () => mockPrefs.setBool('is_reviewed', true),
          ).called(1);
          verify(() => mockReviewWrapper.openStoreListing()).called(1);
        },
      );

      testWidgets(
        'sets new last_prompt_date on tap on remind later button',
        (tester) async {
          when(() => mockPrefs.setBool(any(), any())).thenAnswer((_) async {});
          when(() => mockPrefs.setInt(any(), any())).thenAnswer((_) async {});
          when(() => mockReviewWrapper.openStoreListing()).thenAnswer((_) async {});

          await tester.pumpWidget(
            MaterialApp(
              home: Builder(
                builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      reviewService.showReviewDialog(context);
                    },
                  );
                  return Container();
                },
              ),
            ),
          );

          await tester.pumpAndSettle(Duration(seconds: 3));
          final finder = find.text('Remind Me Later');
          await tester.tap(finder);

          verify(
            () => mockPrefs.setInt('last_prompt_date', any()),
          ).called(1);
        },
      );
    },
  );
}
