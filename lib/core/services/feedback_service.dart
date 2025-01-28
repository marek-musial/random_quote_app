import 'dart:async';
import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:random_quote_app/core/directories.dart';

String _screenshotFilePath = '$tempDirectoryPath/feedback_screenshot.png';

class FeedbackWrapper {
  String screenshotFilePath = _screenshotFilePath;
  String? body;

  void turnOnFeedbackMode(
    BuildContext context, {
    required Future<void> Function(UserFeedback) onFeedback,
  }) {
    BetterFeedback.of(context).show(
      onFeedback,
    );
  }

  void turnOffFeedbackMode(BuildContext context) {
    BetterFeedback.of(context).hide();
  }
}

class FlutterEmailSenderWrapper {
  String screenshotFilePath = _screenshotFilePath;

  Future<void> sendEmail(
    UserFeedback userFeedback,
  ) async {
    await File(screenshotFilePath).writeAsBytes(userFeedback.screenshot);

    final Email email = Email(
      subject: '#Quoteput #Feedback',
      recipients: ['marek.musial.dev@gmail.com'],
      body: userFeedback.text,
      attachmentPaths: [screenshotFilePath],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}

class FeedbackService {
  final FeedbackWrapper feedbackWrapper;
  final FlutterEmailSenderWrapper flutterEmailSenderWrapper;

  FeedbackService({
    FeedbackWrapper? feedbackWrapper,
    FlutterEmailSenderWrapper? flutterEmailSenderWrapper,
  })  : feedbackWrapper = feedbackWrapper ?? FeedbackWrapper(),
        flutterEmailSenderWrapper = flutterEmailSenderWrapper ?? FlutterEmailSenderWrapper();

  void turnOnFeedbackMode(
    BuildContext context,
  ) {
    feedbackWrapper.turnOnFeedbackMode(
      context,
      onFeedback: (feedback) async {
        flutterEmailSenderWrapper.sendEmail(feedback);
      },
    );
  }
}
