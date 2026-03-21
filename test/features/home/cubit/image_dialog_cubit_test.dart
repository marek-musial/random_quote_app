import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/services/image_capture_service.dart';
import 'package:random_quote_app/features/home/cubit/image_dialog_cubit.dart';

class MockImageCaptureService extends Mock implements ImageCaptureService {}

class MockLogger extends Mock implements Logger {}

void main() {
  late ImageDialogCubit sut;
  late Uint8List bytes;
  late MockImageCaptureService mockImageCaptureService;
  registerFallbackValue(Uint8List(0));
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
        sut.imageCaptureService = mockImageCaptureService;
      },
    );

    blocTest(
      'emits the state with calculated file size in KB if the size is < 1 MB',
      build: () => sut,
      act: (cubit) => [
        sut.updateFileSize(976560),
      ],
      expect: () => [
        ImageDialogState(fileSize: '976.56 KB'),
      ],
    );

    blocTest(
      'emits the state with calculated file size in KB if the size is >= 1 MB',
      build: () => sut,
      act: (cubit) => [
        sut.updateFileSize(1200000),
      ],
      expect: () => [
        ImageDialogState(fileSize: '1.20 MB'),
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
        sut.imageCaptureService = mockImageCaptureService;
        bytes = Uint8List(1000000);
      },
    );

    test(
      'succesfully runs imageCaptureService.capturePng',
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
          bytes,
          fileName: 'fileName',
          targetImageDimension: 100,
        );

        verify(
          () => sut.imageCaptureService.capturePng(
            bytes,
            fileName: 'fileName',
            targetImageDimension: 100,
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

        await cubit.capturePng(bytes);
      },
      verify: (cubit) => globalLogger.log('Error on capturing image'),
    );
  });

  group('sharePng', () {
    setUp(
      () {
        mockImageCaptureService = MockImageCaptureService();
        sut.imageCaptureService = mockImageCaptureService;
        bytes = Uint8List(1000000);
      },
    );

    test(
      'succesfully runs imageCaptureService.sharePng',
      () async {
        when(
          () => sut.imageCaptureService.sharePng(any()),
        ).thenAnswer(
          (_) async {},
        );

        await sut.sharePng(bytes);

        verify(
          () => sut.imageCaptureService.sharePng(any()),
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

        await cubit.sharePng(bytes);
      },
      verify: (cubit) => globalLogger.log('Error on sharing image'),
    );
  });
}
