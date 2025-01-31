import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';

import 'package:random_quote_app/core/services/feedback_service.dart';
import 'package:random_quote_app/features/navigation/cubit/navigation_drawer_cubit.dart';

class MockFeedbackService extends Mock implements FeedbackService {}

class MockBuildContext extends Mock implements BuildContext {}

class MockLogger extends Mock implements Logger {}

void main() {
  late NavigationDrawerCubit sut;
  late MockFeedbackService mockFeedbackService;
  late MockBuildContext mockBuildContext;
  globalLogger = MockLogger();

  setUp(
    () {
      sut = NavigationDrawerCubit();
    },
  );

  group(
    'turnOnFeedbackMode',
    () {
      setUp(
        () {
          mockFeedbackService = MockFeedbackService();
          mockBuildContext = MockBuildContext();
          sut.feedbackService = mockFeedbackService;
        },
      );

      test(
        'executes mockFeedbackService.turnOnFeedbackMode',
        () {
          when(
            () => mockFeedbackService.turnOnFeedbackMode(
              mockBuildContext,
            ),
          ).thenAnswer(
            (_) {},
          );

          sut.turnOnFeedbackMode(mockBuildContext);

          verify(
            () => mockFeedbackService.turnOnFeedbackMode(
              mockBuildContext,
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'changeNavigationIndex',
    () {
      blocTest(
        'emits the passed index value and logs the value',
        build: () => sut,
        act: (cubit) => sut.changeNavigationIndex(1),
        expect: () => [
          const NavigationDrawerState(
            navigationIndex: 1,
          ),
        ],
        verify: (cubit) => [
          verify(
            () => globalLogger.log('Page changed to: 1'),
          ).called(1),
        ],
      );
    },
  );
}
