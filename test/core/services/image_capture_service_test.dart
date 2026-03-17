import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/directories.dart';
import 'package:random_quote_app/core/services/image_capture_service.dart';

import 'package:share_plus/share_plus.dart';

class MockLogger extends Mock implements Logger {}

class MockGalWrapper extends Mock implements GalWrapper {}

class MockSharePlusWrapper extends Mock implements SharePlusWrapper {}

void main() {
  late ImageCaptureService imageCaptureService;
  final Uint8List bytes = Uint8List(10);
  final mockLogger = MockLogger();
  globalLogger = mockLogger;
  late MockGalWrapper mockGalWrapper;
  late MockSharePlusWrapper mockSharePlusWrapper;

  setUp(
    () async {
      registerFallbackValue(Uint8List(0));
      registerFallbackValue('');
    },
  );

  group(
    'capturePng',
    () {
      setUp(
        () {
          mockGalWrapper = MockGalWrapper();
          imageCaptureService = ImageCaptureService(
            galWrapper: mockGalWrapper,
          );
        },
      );

      test('runs the image saving logic on correct values, and logs the name of the saved image', () async {
        when(
          () => mockGalWrapper.putImageBytes(
            any(),
            name: 'nameString',
          ),
        ).thenAnswer(
          (_) async {},
        );

        await imageCaptureService.capturePng(
          bytes,
          fileName: 'nameString',
          targetImageDimension: 100,
        );

        verify(
          () => mockGalWrapper.putImageBytes(
            bytes,
            name: 'nameString',
          ),
        ).called(1);
        verify(
          () => globalLogger.log(
            'Saved image name: nameString',
          ),
        ).called(1);
      });

      test('when file name is empty, uses timestamp', () async {
        when(
          () => mockGalWrapper.putImageBytes(
            any(),
            name: any(named: 'name'),
          ),
        ).thenAnswer(
          (_) async {},
        );

        await imageCaptureService.capturePng(
          bytes,
          fileName: null,
          targetImageDimension: 100,
        );

        verify(
          () => mockGalWrapper.putImageBytes(
            bytes,
            name: 'image_${imageCaptureService.timestamp}',
          ),
        ).called(1);
        verify(
          () => globalLogger.log(
            'Saved image name: image_${imageCaptureService.timestamp}',
          ),
        ).called(1);
      });
    },
  );

  group(
    'sharePng',
    () {
      late Directory tempDirectory;
      setUp(
        () async {
          mockSharePlusWrapper = MockSharePlusWrapper();
          imageCaptureService = ImageCaptureService(
            sharePlusWrapper: mockSharePlusWrapper,
          );
          tempDirectory = Directory.systemTemp.createTempSync();
          tempDirectoryPath = tempDirectory.path;
        },
      );

      tearDown(
        () async {
          if (tempDirectory.existsSync()) {
            tempDirectory.deleteSync(recursive: true);
          }
        },
      );

      test(
        'runs the image sharing logic with correct values, and on status = success logs the success',
        () async {
          when(
            () => mockSharePlusWrapper.shareXFiles(any()),
          ).thenAnswer(
            (_) async => const ShareResult(
              'raw',
              ShareResultStatus.success,
            ),
          );

          await imageCaptureService.sharePng(
            bytes,
            fileName: 'nameString',
            targetImageDimension: 100,
          );

          verify(
            () => mockSharePlusWrapper.shareXFiles(
              '$tempDirectoryPath/nameString.png',
            ),
          ).called(1);
          verify(
            () => mockLogger.log(
              'Image nameString shared successfully',
            ),
          ).called(1);
        },
      );

      test(
        'runs the image sharing logic with correct values, and on status = dismissed logs the appropriate message',
        () async {
          when(
            () => mockSharePlusWrapper.shareXFiles(any()),
          ).thenAnswer(
            (_) async => const ShareResult(
              'raw',
              ShareResultStatus.dismissed,
            ),
          );

          await imageCaptureService.sharePng(
            bytes,
            fileName: 'nameString',
          );

          verify(
            () => mockSharePlusWrapper.shareXFiles(
              '$tempDirectoryPath/nameString.png',
            ),
          ).called(1);
          verify(
            () => mockLogger.log(
              'Image nameString sharing dismissed',
            ),
          ).called(1);
        },
      );

      test(
        'runs the image sharing logic with correct values, and on any other status logs the appropriate message',
        () async {
          late ShareResult result;
          when(
            () => mockSharePlusWrapper.shareXFiles(any()),
          ).thenAnswer(
            (_) async => result = const ShareResult(
              'raw',
              ShareResultStatus.unavailable,
            ),
          );

          await imageCaptureService.sharePng(
            bytes,
            fileName: 'nameString',
          );

          verify(
            () => mockSharePlusWrapper.shareXFiles(
              '$tempDirectoryPath/nameString.png',
            ),
          ).called(1);
          verify(
            () => mockLogger.log(
              'An error occured with share result status ${result.status.toString()}',
            ),
          ).called(1);
        },
      );

      test('when file name is empty, uses timestamp', () async {
        when(
          () => mockSharePlusWrapper.shareXFiles(any()),
        ).thenAnswer(
          (_) async => const ShareResult(
            'raw',
            ShareResultStatus.success,
          ),
        );

        await imageCaptureService.sharePng(
          bytes,
          fileName: null,
          targetImageDimension: 100,
        );

        verify(
          () => mockSharePlusWrapper.shareXFiles(
            '$tempDirectoryPath/image_${imageCaptureService.timestamp}.png',
          ),
        ).called(1);
        verify(
          () => globalLogger.log(
            'Image image_${imageCaptureService.timestamp} shared successfully',
          ),
        ).called(1);
      });
    },
  );
}
