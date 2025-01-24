import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/directories.dart';
import 'package:random_quote_app/core/services/image_capture_service.dart';

import 'package:share_plus/share_plus.dart';

class MockRenderRepaintBoundary extends Mock implements RenderRepaintBoundary {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockRepaintBoundary';
  }
}

class MockImage extends Mock implements ui.Image {}

class MockLogger extends Mock implements Logger {}

class MockGalWrapper extends Mock implements GalWrapper {}

class MockSharePlusWrapper extends Mock implements SharePlusWrapper {}

void main() {
  late ImageCaptureService imageCaptureService;
  final mockRenderRepaintBoundary = MockRenderRepaintBoundary();
  final mockImage = MockImage();
  final mockLogger = MockLogger();
  globalLogger = mockLogger;
  late MockGalWrapper mockGalWrapper;
  late MockSharePlusWrapper mockSharePlusWrapper;
  final byteData = ByteData(8)..setInt64(0, 12345);
  final pngBytes = byteData.buffer.asUint8List();

  setUp(
    () async {
      registerFallbackValue(Uint8List(0));
      registerFallbackValue('');

      when(
        () => mockImage.width,
      ).thenReturn(1920);
      when(
        () => mockImage.height,
      ).thenReturn(1080);
      when(
        () => mockRenderRepaintBoundary.size,
      ).thenReturn(
        Size(320, 420),
      );
      when(
        () => mockRenderRepaintBoundary.toImage(
          pixelRatio: any(
            named: 'pixelRatio',
          ),
        ),
      ).thenAnswer(
        (_) async => mockImage,
      );
      when(
        () => mockImage.toByteData(format: ui.ImageByteFormat.png),
      ).thenAnswer(
        (_) async => byteData,
      );
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

      test('runs the image saving logic on correct values, and logs the name and the size of the saved image', () async {
        when(
          () => mockGalWrapper.putImageBytes(
            any(),
            name: 'nameString',
          ),
        ).thenAnswer(
          (_) async {},
        );

        await imageCaptureService.capturePng(
          mockRenderRepaintBoundary,
          fileName: 'nameString',
          targetImageDimension: 100,
        );

        verify(
          () => mockGalWrapper.putImageBytes(
            pngBytes,
            name: 'nameString',
          ),
        ).called(1);
        verify(
          () => globalLogger.log(
            'Saved image name: nameString',
          ),
        ).called(1);
        verify(
          () => mockLogger.log(
            'Saved image width: ${mockImage.width}, saved image height: ${mockImage.height}',
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
        'runs the image sharing logic with correct values, and on status = success logs the size of the shared image',
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
            mockRenderRepaintBoundary,
            fileName: 'nameString',
          );

          verify(
            () => mockSharePlusWrapper.shareXFiles(
              '$tempDirectoryPath/nameString.png',
            ),
          ).called(1);
          verify(
            () => mockLogger.log(
              'Shared image width: ${mockImage.width}, saved image height: ${mockImage.height}',
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
            mockRenderRepaintBoundary,
            fileName: 'nameString',
          );

          verify(
            () => mockSharePlusWrapper.shareXFiles(
              '$tempDirectoryPath/nameString.png',
            ),
          ).called(1);
          verify(
            () => mockLogger.log(
              'Image sharing dismissed',
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
            mockRenderRepaintBoundary,
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
    },
  );
}
