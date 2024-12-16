import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/services/image_capture_service.dart';

class MockRenderRepaintBoundary extends Mock implements RenderRepaintBoundary {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockRepaintBoundary';
  }
}

class MockImage extends Mock implements ui.Image {}

class MockLogger extends Mock implements Logger {}

class MockGalWrapper extends Mock implements GalWrapper {}

void main() {
  late ImageCaptureService imageCaptureService;
  final mockRenderRepaintBoundary = MockRenderRepaintBoundary();
  final mockImage = MockImage();
  final mockLogger = MockLogger();
  globalLogger = mockLogger;
  late MockGalWrapper mockGalWrapper;
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
        () => mockRenderRepaintBoundary.toImage(),
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
}
