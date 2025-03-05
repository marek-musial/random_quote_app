import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:random_quote_app/core/services/feedback_service.dart';

import 'package:feedback/feedback.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class MockFeedbackWrapper extends Mock implements FeedbackWrapper {}

class MockFlutterEmailSenderWrapper extends Mock implements FlutterEmailSenderWrapper {}

class MockBuildContext extends Mock implements BuildContext {}

class FakeBuildContext extends Fake implements BuildContext {}

class FakeEmail extends Fake implements Email {}

class MockUserFeedback extends Mock implements UserFeedback {}

class MockCompileAndSendEmail extends Mock {
  Future<void> call(UserFeedback feedback);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late FeedbackService feedbackService;
  late MockFeedbackWrapper mockFeedbackWrapper;
  late MockFlutterEmailSenderWrapper mockFlutterEmailSenderWrapper;
  late MockBuildContext mockBuildContext;
  late UserFeedback userFeedback;
  late Email email;
  late MockCompileAndSendEmail mockCompileAndSendEmail;

  setUp(
    () {
      mockFeedbackWrapper = MockFeedbackWrapper();
      mockFlutterEmailSenderWrapper = MockFlutterEmailSenderWrapper();
      registerFallbackValue(FakeEmail());
    },
  );

  group(
    'compileAndSendEmail',
    () {
      setUp(
        () {
          feedbackService = FeedbackService(
            flutterEmailSenderWrapper: mockFlutterEmailSenderWrapper,
          );

          userFeedback = UserFeedback(
            text: 'email body',
            screenshot: Uint8List(1),
          );

          feedbackService.screenshotFilePath = 'path';

          email = Email(
            subject: '#Quoteput #Feedback',
            recipients: ['marek.musial.dev@gmail.com'],
            body: userFeedback.text,
            attachmentPaths: [feedbackService.screenshotFilePath],
            isHTML: false,
          );
        },
      );

      test(
        'runs flutterEmailSenderWrapper.sendEmail with proper values',
        () async {
          when(
            () => mockFlutterEmailSenderWrapper.sendEmail(any()),
          ).thenAnswer((_) async {});

          await feedbackService.compileAndSendEmail(userFeedback);

          verify(
            () => mockFlutterEmailSenderWrapper.sendEmail(
              any(
                that: isA<Email>()
                    .having(
                      (subject) => email.subject,
                      'subject',
                      '#Quoteput #Feedback',
                    )
                    .having(
                      (recipients) => email.recipients,
                      'recipients',
                      ['marek.musial.dev@gmail.com'],
                    )
                    .having(
                      (body) => email.body,
                      'body',
                      'email body',
                    )
                    .having(
                      (attachmentPaths) => email.attachmentPaths,
                      'attachmentPaths',
                      ['path'],
                    ),
              ),
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'turnOnFeedbackMode',
    () {
      setUp(
        () {
          feedbackService = FeedbackService(
            feedbackWrapper: mockFeedbackWrapper,
            flutterEmailSenderWrapper: mockFlutterEmailSenderWrapper,
          );
          mockBuildContext = MockBuildContext();
          userFeedback = UserFeedback(
            text: 'email body',
            screenshot: Uint8List(1),
          );
          mockCompileAndSendEmail = MockCompileAndSendEmail();
          registerFallbackValue(FakeBuildContext());
          registerFallbackValue(
            UserFeedback(
              text: 'text',
              screenshot: Uint8List(1),
            ),
          );
          feedbackService.screenshotFilePath = 'path';
        },
      );

      test(
        'calls compileAndSendEmail when feedback is submitted',
        () async {
          Future<void> Function(UserFeedback)? capturedOnFeedback;
          when(() => mockFeedbackWrapper.turnOnFeedbackMode(
                any(),
                onFeedback: any(named: 'onFeedback'),
              )).thenAnswer((invocation) {
            capturedOnFeedback = invocation.namedArguments[#onFeedback] //R
                as Future<void> Function(UserFeedback);
          });
          when(
            () => mockFlutterEmailSenderWrapper.sendEmail(
              any(),
            ),
          ).thenAnswer(
            (_) => mockCompileAndSendEmail.call(userFeedback),
          );
          when(
            () => mockCompileAndSendEmail.call(
              any(),
            ),
          ).thenAnswer(
            (_) async {},
          );

          feedbackService.turnOnFeedbackMode(
            mockBuildContext,
          );
          expect(capturedOnFeedback, isNotNull);
          await capturedOnFeedback!(userFeedback);

          verify(
            () => mockCompileAndSendEmail.call(userFeedback),
          ).called(1);
        },
      );
    },
  );
}
