import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/services/image_capture_service.dart';
import 'package:random_quote_app/features/home/cubit/image_dialog_cubit.dart';

class MockImageCaptureService extends Mock implements ImageCaptureService {}

class MockRenderRepaintBoundary extends Mock implements RenderRepaintBoundary {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockRepaintBoundary';
  }
}

class MockImage extends Mock implements ui.Image {}

class MockLogger extends Mock implements Logger {}

void main() {
  late ImageDialogCubit sut;
  late MockRenderRepaintBoundary mockRenderRepaintBoundary;
  late MockImage mockImage;
  late ByteData? byteData;
  late MockImageCaptureService mockImageCaptureService;
  registerFallbackValue(RenderRepaintBoundary());
  globalLogger = MockLogger();

  setUp(
    () {
      sut = ImageDialogCubit();
    },
  );

  group('updateFileSize', () {
    setUp(
      () {
        mockImageCaptureService = MockImageCaptureService();
        mockRenderRepaintBoundary = MockRenderRepaintBoundary();
        mockImage = MockImage();
        sut.imageCaptureService = mockImageCaptureService;
        when(
          () => mockRenderRepaintBoundary.size,
        ).thenReturn(
          const Size(100, 200),
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

    blocTest(
      'emits the state with calculated file size in KB if the size is < 1 MB',
      build: () => sut,
      act: (cubit) => [
        byteData = ByteData(1000000)..setInt64(0, 1),
        sut.updateFileSize(
          mockRenderRepaintBoundary,
          100,
        ),
      ],
      expect: () => [
        ImageDialogState(fileSize: '976.56 KB'),
      ],
    );

    blocTest(
      'emits the state with calculated file size in KB if the size is >= 1 MB',
      build: () => sut,
      act: (cubit) => [
        byteData = ByteData(1200000)..setInt64(0, 1),
        sut.updateFileSize(
          mockRenderRepaintBoundary,
          100,
        ),
      ],
      expect: () => [
        ImageDialogState(fileSize: '1.14 MB'),
      ],
    );

    blocTest(
      'emits the state with null file size if the byteData = null',
      build: () => sut,
      act: (cubit) => [
        byteData = null,
        sut.updateFileSize(
          mockRenderRepaintBoundary,
          100,
        ),
      ],
      expect: () => [
        ImageDialogState(fileSize: null),
      ],
    );
  });

  group('updateImageDimension', () {
    blocTest(
      'emits the state with updated image dimension while not changing any other values',
      build: () => sut,
      act: (cubit) => [
        sut.emit(
          ImageDialogState(
            imageDimension: 200,
            fileName: 'name',
          ),
        ),
        sut.updateImageDimension(100),
      ],
      expect: () => [
        ImageDialogState(
          imageDimension: 200,
          fileName: 'name',
        ),
        ImageDialogState(
          imageDimension: 100,
          fileName: 'name',
        ),
      ],
    );
  });

  group('updateImageName', () {
    blocTest(
      'emits the state with updated image name while not changing any other values',
      build: () => sut,
      act: (cubit) => [
        sut.emit(
          ImageDialogState(
            imageDimension: 200,
            fileName: 'nameA',
          ),
        ),
        sut.updateImageName('nameB'),
      ],
      expect: () => [
        ImageDialogState(
          imageDimension: 200,
          fileName: 'nameA',
        ),
        ImageDialogState(
          imageDimension: 200,
          fileName: 'nameB',
        ),
      ],
    );
  });

  group('capturePng', () {
    setUp(
      () {
        mockImageCaptureService = MockImageCaptureService();
        mockRenderRepaintBoundary = MockRenderRepaintBoundary();
        sut.imageCaptureService = mockImageCaptureService;
        when(
          () => mockRenderRepaintBoundary.size,
        ).thenReturn(
          const Size(100, 200),
        );
      },
    );

    test(
      'succesfully runs imageCaptureService.capturePng, logs boundary size',
      () async {
        when(
          () => sut.imageCaptureService.capturePng(
            any(),
            fileName: any(named: 'fileName'),
            targetImageDimension: any(named: 'targetImageDimension'),
          ),
        ).thenAnswer(
          (_) async {},
        );

        await sut.capturePng(
          mockRenderRepaintBoundary,
          fileName: 'fileName',
          targetImageDimension: 100,
        );

        verify(
          () => sut.imageCaptureService.capturePng(
            mockRenderRepaintBoundary,
            fileName: 'fileName',
            targetImageDimension: 100,
          ),
        );
        verify(
          () => globalLogger.log(
            'Boundary width: ${mockRenderRepaintBoundary.size.width}, boundary height: ${mockRenderRepaintBoundary.size.height}',
          ),
        );
      },
    );

    blocTest(
      'emits error state when capturing png fails and logs the error',
      build: () => sut,
      act: (cubit) async {
        when(
          () => mockImageCaptureService.capturePng(any()),
        ).thenThrow(
          Exception('Error on capturing image'),
        );

        await cubit.capturePng(mockRenderRepaintBoundary);
      },
      verify: (cubit) => globalLogger.log('Error on capturing image'),
    );
  });

  group('sharePng', () {
    setUp(
      () {
        mockImageCaptureService = MockImageCaptureService();
        mockRenderRepaintBoundary = MockRenderRepaintBoundary();
        sut.imageCaptureService = mockImageCaptureService;
        when(
          () => mockRenderRepaintBoundary.size,
        ).thenReturn(
          const Size(100, 200),
        );
      },
    );

    test(
      'succesfully runs imageCaptureService.sharePng, logs boundary size',
      () async {
        when(
          () => sut.imageCaptureService.sharePng(any()),
        ).thenAnswer(
          (_) async {},
        );

        await sut.sharePng(mockRenderRepaintBoundary);

        verify(
          () => sut.imageCaptureService.sharePng(any()),
        );
        verify(
          () => globalLogger.log(
            'Boundary width: ${mockRenderRepaintBoundary.size.width}, boundary height: ${mockRenderRepaintBoundary.size.height}',
          ),
        );
      },
    );

    blocTest(
      'emits error state when sharing png fails and logs the error',
      build: () => sut,
      act: (cubit) async {
        when(
          () => mockImageCaptureService.sharePng(any()),
        ).thenThrow(
          Exception('Error on sharing image'),
        );

        await cubit.sharePng(mockRenderRepaintBoundary);
      },
      verify: (cubit) => globalLogger.log('Error on sharing image'),
    );
  });
}
