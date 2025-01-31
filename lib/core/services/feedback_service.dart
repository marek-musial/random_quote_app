import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:feedback/feedback.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:random_quote_app/core/directories.dart';

String _screenshotFilePath = '$tempDirectoryPath/feedback_screenshot.png';

class FeedbackWrapper {
  void turnOnFeedbackMode(
    BuildContext context, {
    required Future<void> Function(UserFeedback) onFeedback,
  }) {
    BetterFeedback.of(context).show(
      onFeedback,
    );
  }
}

class FlutterEmailSenderWrapper {
  Future<void> sendEmail(Email email) async {
    await FlutterEmailSender.send(email);
  }
}

class FeedbackService {
  final FeedbackWrapper feedbackWrapper;
  final FlutterEmailSenderWrapper flutterEmailSenderWrapper;
  String screenshotFilePath = _screenshotFilePath;

  FeedbackService({
    FeedbackWrapper? feedbackWrapper,
    FlutterEmailSenderWrapper? flutterEmailSenderWrapper,
  })  : feedbackWrapper = feedbackWrapper ?? //R
            FeedbackWrapper(),
        flutterEmailSenderWrapper = flutterEmailSenderWrapper ?? //R
            FlutterEmailSenderWrapper();

  Future<void> compileAndSendEmail(UserFeedback feedback) async {
    await File(screenshotFilePath).writeAsBytes(feedback.screenshot);

    final Email email = Email(
      subject: '#Quoteput #Feedback',
      recipients: ['marek.musial.dev@gmail.com'],
      body: feedback.text,
      attachmentPaths: [screenshotFilePath],
      isHTML: false,
    );

    await flutterEmailSenderWrapper.sendEmail(email);
  }

  void turnOnFeedbackMode(
    BuildContext context,
  ) {
    feedbackWrapper.turnOnFeedbackMode(
      context,
      onFeedback: (feedback) async {
        await compileAndSendEmail(feedback);
      },
    );
  }
}
