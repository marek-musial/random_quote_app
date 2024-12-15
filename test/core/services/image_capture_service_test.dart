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
  late MockRenderRepaintBoundary mockRenderRepaintBoundary;
  late MockImage mockImage;
  late MockLogger mockLogger;
  late MockGalWrapper mockGalWrapper;
  late ByteData byteData;

  setUp(
    () {
      mockRenderRepaintBoundary = MockRenderRepaintBoundary();
      mockImage = MockImage();
      mockLogger = MockLogger();
      globalLogger = mockLogger;

      registerFallbackValue(Uint8List(0));
      registerFallbackValue('');

      byteData = ByteData(8)..setInt64(0, 12345);
      when(
        () => mockImage.width,
      ).thenReturn(1920);
      when(
        () => mockImage.height,
      ).thenReturn(1080);
    },
  );

  group(
    'capturePng',
    () {
      test('run the image saving logic on correct values, and log the size of the saved image', () async {
        mockGalWrapper = MockGalWrapper();
        final imageCaptureService = ImageCaptureService(
          galWrapper: mockGalWrapper,
        );

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
        when(
          () => mockGalWrapper.putImageBytes(
            any(),
            name: any(named: 'name'),
          ),
        ).thenAnswer(
          (_) async {},
        );

        await imageCaptureService.capturePng(
          mockRenderRepaintBoundary,
        );

        verify(
          () => mockGalWrapper.putImageBytes(
            any(),
            name: any(named: 'name'),
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
