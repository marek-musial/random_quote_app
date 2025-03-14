import 'dart:ui' as ui;

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/network_utils.dart';
import 'package:random_quote_app/core/services/image_capture_service.dart';
import 'package:random_quote_app/core/services/palette_generator_service.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';

class MockImageRepository extends Mock implements ImageRepository {}

class MockQuoteRepository extends Mock implements QuoteRepository {}

class MockStorage extends Mock implements Storage {}

class MockImage extends Mock implements ui.Image {}

class MockImageLoader extends Mock implements ImageLoader {}

class MockImageProvider extends Mock implements ImageProvider {}

class MockPaletteGeneratorService extends Mock implements PaletteGeneratorService {}

class FakeSize extends Fake implements Size {}

class FakeRect extends Fake implements Rect {}

class MockImageCaptureService extends Mock implements ImageCaptureService {}

class MockRenderRepaintBoundary extends Mock implements RenderRepaintBoundary {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockRepaintBoundary';
  }
}

class MockLogger extends Mock implements Logger {}

class MockConnectivity extends Mock implements Connectivity {}

void main() async {
  late Storage storage;
  late HomeCubit sut;
  late MockImageRepository imageRepository;
  late MockQuoteRepository quoteRepository;
  late MockImage mockImage;
  late MockImageLoader mockImageLoader;
  late MockImageProvider mockImageProvider;
  late MockPaletteGeneratorService mockPaletteGeneratorService;
  globalLogger = MockLogger();
  late MockConnectivity mockConnectivity;

  WidgetsFlutterBinding.ensureInitialized();

  void initHydratedStorage() {
    storage = MockStorage();
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  }

  setUp(
    () {
      initHydratedStorage();
      imageRepository = MockImageRepository();
      quoteRepository = MockQuoteRepository();
      sut = HomeCubit(imageRepository, quoteRepository);
    },
  );

  group('emitPreviousState', () {
    setUp(
      () {
        sut.previousState = HomeState(
          status: Status.success,
          imageModel: ImageModel(
            imageUrl: 'previousImageUrl',
            author: '',
            rawImage: mockImage,
            scaleFactor: .5,
          ),
          quoteModel: QuoteModel(
            quote: 'previousQuote',
          ),
        );
      },
    );

    blocTest(
      'on previousState != state, updates previousState with successful state and logs success messages',
      build: () => sut,
      act: (cubit) => [
        sut.emit(
          const HomeState(
            status: Status.error,
            errorMessage: 'errorMessage',
          ),
        ),
        sut.emitPreviousState(),
      ],
      expect: () => [
        const HomeState(
          status: Status.error,
          errorMessage: 'errorMessage',
        ),
        sut.previousState,
      ],
      verify: (cubit) => [
        verify(
          () => globalLogger.log('previous state emitted'),
        ).called(1),
        expect(sut.previousState == sut.state, true),
      ],
    );

    blocTest(
      'on previousState == state, does not update previousState with the new state and logs the apropriate message',
      build: () => sut,
      act: (cubit) => [
        sut.emit(
          sut.previousState,
        ),
        sut.emitPreviousState(),
      ],
      expect: () => [
        sut.previousState,
      ],
      verify: (cubit) => [
        verify(
          () => globalLogger.log(
            'previous state not emitted',
          ),
        ).called(1),
        expect(sut.previousState == sut.state, true),
      ],
    );

    blocTest(
      'on previousState != state, but previousState status != Status.success, does not update previousState with the new state and logs the apropriate message',
      build: () => sut,
      act: (cubit) => [
        sut.emit(
          sut.previousState.copyWith(
            status: Status.loading,
          ),
        ),
        sut.previousState = sut.previousState.copyWith(
          status: Status.error,
        ),
        sut.emitPreviousState(),
      ],
      expect: () => [
        sut.previousState.copyWith(
          status: Status.loading,
        ),
      ],
      verify: (cubit) => [
        verify(
          () => globalLogger.log(
            'previous state not emitted',
          ),
        ).called(1),
        expect(sut.previousState != sut.state, true),
      ],
    );
  });

  group('getItemModels', () {
    setUp(
      () {
        when(() => imageRepository.getImageModel()).thenAnswer(
          (_) async => ImageModel(
            imageUrl: 'imageUrl',
            author: 'imageAuthor',
          ),
        );
        when(() => quoteRepository.getQuoteModel()).thenAnswer(
          (_) async => QuoteModel(
            quote: 'quote',
            author: 'quoteAuthor',
          ),
        );
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits Status.loading then Status.loading with results',
      build: () => sut,
      act: (cubit) => cubit.getItemModels(),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.status,
          'status',
          Status.loading,
        ),
        isA<HomeState>()
            .having(
              (state) => state.status,
              'status',
              Status.loading,
            )
            .having(
              (state) => state.imageModel!.imageUrl,
              'imageUrl',
              'imageUrl',
            )
            .having(
              (state) => state.quoteModel!.quote,
              'quote',
              'quote',
            ),
      ],
    );

    group('failure on getting image model', () {
      setUp(
        () {
          when(() => imageRepository.getImageModel()).thenThrow(
            Exception('Error fetching image'),
          );
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits Status.loading then Status.error with error message and logs the error',
        build: () => sut,
        act: (cubit) => cubit.getItemModels(),
        expect: () => [
          const HomeState(status: Status.loading),
          const HomeState(
            status: Status.error,
            errorMessage: 'Exception: Error fetching image',
          ),
        ],
        verify: (cubit) => globalLogger.log,
      );
    });

    group(
      'failure on getting quote model',
      () {
        setUp(() {
          when(
            () => quoteRepository.getQuoteModel(),
          ).thenThrow(
            Exception(
              'Error fetching quote',
            ),
          );
        });

        blocTest<HomeCubit, HomeState>(
          'emits Status.loading then Status.errorwith error message and logs the error',
          build: () => sut,
          act: (cubit) => cubit.getItemModels(),
          expect: () => [
            const HomeState(status: Status.loading),
            const HomeState(
              status: Status.error,
              errorMessage: 'Exception: Error fetching quote',
            ),
          ],
          verify: (cubit) => globalLogger.log,
        );
      },
    );
  });

  group('loadImage', () {
    setUp(
      () {
        mockImageLoader = MockImageLoader();
        mockImage = MockImage();

        sut.emit(
          HomeState(
            status: Status.loading,
            imageModel: ImageModel(
              imageUrl: 'imageUrl',
              author: 'author',
            ),
            quoteModel: QuoteModel(
              quote: 'quote',
            ),
          ),
        );
        sut.pendingState = sut.state;
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits state with imageModel.rawImage when image loads successfully, logs image size',
      build: () => sut,
      act: (cubit) async {
        when(
          () => mockImageLoader.loadImage(any()),
        ).thenAnswer((_) async {
          return mockImage;
        });
        when(() => mockImage.width).thenReturn(100);
        when(() => mockImage.height).thenReturn(200);
        cubit.imageLoader = mockImageLoader;

        await cubit.loadImage();
      },
      expect: () => [
        isA<HomeState>()
            .having(
              (state) => state.imageModel!.rawImage,
              'rawImage',
              isNotNull,
            )
            .having(
              (state) => state.status,
              'status',
              Status.loading,
            ),
      ],
      verify: (cubit) => globalLogger.log(
        'Width: ${mockImage.width}, height: ${mockImage.height}',
      ),
    );

    blocTest<HomeCubit, HomeState>(
      'emits error state when image loading fails and logs the error',
      build: () => sut,
      act: (cubit) async {
        when(
          () => mockImageLoader.loadImage(any()),
        ).thenThrow(
          Exception('Error loading image'),
        );
        cubit.imageLoader = mockImageLoader;
        await cubit.loadImage();
      },
      expect: () => [
        isA<HomeState>()
            .having(
              (state) => state.status,
              'status',
              Status.error,
            )
            .having(
              (state) => state.errorMessage,
              'errorMessage',
              'Failed to load image, check your network connection',
            ),
      ],
      verify: (cubit) => globalLogger.log,
    );
    blocTest<HomeCubit, HomeState>(
      'logs error when imageModel is null',
      build: () => sut,
      seed: () {
        sut.pendingState = const HomeState(
          status: Status.loading,
          imageModel: null,
        );
        return const HomeState(
          status: Status.loading,
          imageModel: null,
        );
      },
      act: (cubit) async {
        await cubit.loadImage();
      },
      verify: (cubit) => globalLogger.log,
    );
  });

  group('randomizeTextLayout', () {
    test(
      'layout is randomized within range, logs success message',
      () {
        sut.emit(const HomeState(status: Status.loading));
        sut.pendingState = HomeState(
          status: Status.loading,
          quoteModel: QuoteModel(
            quote: 'quote',
            fontWeightIndex: 1,
            textAlignmentIndex: 4,
            mainAxisAlignmentIndex: 4,
            crossAxisAlignmentIndex: 4,
          ),
        );

        sut.randomizeTextLayout();
        QuoteModel? quoteModel = sut.pendingState.quoteModel;

        expect(
          quoteModel?.fontWeightIndex,
          inInclusiveRange(3, 8),
        );
        expect(
          quoteModel?.textAlignmentIndex,
          inInclusiveRange(0, 2),
        );
        expect(
          quoteModel?.mainAxisAlignmentIndex,
          inInclusiveRange(0, 2),
        );
        expect(
          quoteModel?.crossAxisAlignmentIndex,
          inInclusiveRange(0, 2),
        );
        verify(
          () => globalLogger.log(
            'layout randomized',
          ),
        );
      },
    );

    test(
      'layout is not randomized due to decoding status, logs a message',
      () {
        sut.emit(const HomeState(status: Status.decoding));
        sut.pendingState = HomeState(
          status: Status.decoding,
          quoteModel: QuoteModel(
            quote: 'quote',
            fontWeightIndex: 1,
            textAlignmentIndex: 1,
            mainAxisAlignmentIndex: 1,
            crossAxisAlignmentIndex: 1,
          ),
        );
        sut.randomizeTextLayout();
        QuoteModel? quoteModel = sut.pendingState.quoteModel;
        expect(quoteModel?.fontWeightIndex, 1);
        expect(quoteModel?.textAlignmentIndex, 1);
        expect(quoteModel?.mainAxisAlignmentIndex, 1);
        expect(quoteModel?.crossAxisAlignmentIndex, 1);
        verify(
          () => globalLogger.log(
            'layout not randomized',
          ),
        );
      },
    );
  });

  group('getTextPositionAndSize', () {
    setUp(
      () {
        sut.pendingState = HomeState(
          status: Status.loading,
          quoteModel: QuoteModel(
            quote: 'quote',
          ),
        );
      },
    );

    test(
      'gets passed pendingState textPosition and textSize and logs the values',
      () {
        sut.getTextPositionAndSize(
          const Offset(1, 1),
          const Size(1, 1),
        );
        QuoteModel? quoteModel = sut.pendingState.quoteModel;
        expect(
          quoteModel?.textPosition,
          const Offset(1, 1),
        );
        expect(
          quoteModel?.textSize,
          const Size(1, 1),
        );
        verify(
          () => globalLogger.log(
            'New textPosition: Offset(1.0, 1.0), new textSize: Size(1.0, 1.0)',
          ),
        ).called(1);
      },
    );
  });

  group('calculateScaleFactor', () {
    setUp(() {
      mockImage = MockImage();
    });

    test(
      'calculates scaleFactor correctly, logs the scaleFactor',
      () {
        sut.pendingState = HomeState(
          status: Status.loading,
          imageModel: ImageModel(
            imageUrl: 'imageUrl',
            author: '',
            rawImage: mockImage,
          ),
        );
        sut.emit(
          sut.pendingState,
        );
        when(
          () => mockImage.width,
        ).thenReturn(100);
        when(() => mockImage.height).thenReturn(200);

        sut.calculateScaleFactor(const Size(200, 100));

        expect(sut.pendingState.imageModel?.scaleFactor, .5);
        verify(
          () => globalLogger.log(
            'scaleFactor: ${sut.pendingState.imageModel?.scaleFactor}',
          ),
        );
      },
    );

    blocTest(
      'emits an error state when the image passed for calculation is null and logs the error',
      build: () => sut,
      seed: () => HomeState(
        status: Status.loading,
        imageModel: ImageModel(
          imageUrl: 'imageUrl',
          author: '',
          rawImage: null,
        ),
      ),
      act: (cubit) => cubit.calculateScaleFactor(const Size(200, 100)),
      expect: () => [
        isA<HomeState>()
            .having(
              (state) => state.status,
              'status',
              Status.error,
            )
            .having(
              (state) => state.errorMessage,
              'errorMessage',
              'Scale factor calculation error',
            ),
      ],
      verify: (cubit) => globalLogger.log,
    );
  });

  group('generateColors', () {
    mockImage = MockImage();
    mockImageLoader = MockImageLoader();
    mockPaletteGeneratorService = MockPaletteGeneratorService();
    mockImageProvider = MockImageProvider();

    registerFallbackValue(FakeSize());
    registerFallbackValue(FakeRect());

    setUp(
      () {
        sut.pendingState = HomeState(
          status: Status.loading,
          imageModel: ImageModel(
            imageUrl: 'imageUrl',
            author: '',
            rawImage: mockImage,
            scaleFactor: .8,
          ),
          quoteModel: QuoteModel(
            quote: 'quote',
            textPosition: const Offset(10, 10),
            textSize: const Size(50, 20),
          ),
        );
        sut.paletteGeneratorService = mockPaletteGeneratorService;
      },
    );

    test(
      'generates color correctly, logs the color value and success message',
      () async {
        imageProvider = mockImageProvider;

        when(
          () => mockPaletteGeneratorService.generateColors(
            mockImageProvider,
            any(),
            any(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            const ui.Color.fromARGB(255, 0, 0, 0),
          ),
        );
        when(() => mockImage.width).thenReturn(400);
        when(() => mockImage.height).thenReturn(600);

        await sut.generateColors();

        expect(
          sut.pendingState.quoteModel?.textColor,
          const ui.Color.fromARGB(255, 255, 255, 255),
        );
        verifyInOrder(
          [
            () => globalLogger.log(
                  'textColor = ${sut.pendingState.quoteModel?.textColor}',
                ),
            () => globalLogger.log(
                  'palette generated!',
                ),
          ],
        );
      },
    );

    blocTest(
      'emits an error state when color generator service fails and logs the error',
      build: () => sut,
      seed: () {
        imageProvider = mockImageProvider;
        return sut.pendingState;
      },
      act: (cubit) async {
        when(
          () => mockPaletteGeneratorService.generateColors(
            mockImageProvider,
            any(),
            any(),
          ),
        ).thenThrow(
          Exception('Error generating colors'),
        );
        when(() => mockImage.width).thenReturn(400);
        when(() => mockImage.height).thenReturn(600);

        await cubit.generateColors();
      },
      expect: () => [
        isA<HomeState>()
            .having(
              (state) => state.status,
              'status',
              Status.error,
            )
            .having(
              (state) => state.errorMessage,
              'errorMessage',
              'Exception: Error generating colors',
            ),
      ],
      verify: (cubit) => globalLogger.log,
    );

    blocTest(
      'emits an error state when an argument passed to color generator is null and logs the error',
      build: () => sut,
      seed: () {
        imageProvider = null;
        return sut.pendingState;
      },
      act: (cubit) async {
        await cubit.generateColors();
      },
      expect: () => [
        isA<HomeState>()
            .having(
              (state) => state.status,
              'status',
              Status.error,
            )
            .having(
              (state) => state.errorMessage,
              'errorMessage',
              'Error while generating color',
            ),
      ],
      verify: (cubit) => globalLogger.log,
    );
  });

  group('getInverseColor', () {
    test(
      'inverts all rgb values of the passed color and returns color with max alpha value',
      () {
        Color testColor = const ui.Color.fromARGB(200, 55, 100, 200);

        Color inverseColor = sut.getInverseColor(testColor);

        expect(inverseColor, const Color.fromARGB(255, 200, 155, 55));
      },
    );

    test(
      'on high rgb values (color is nearly white) of the passed color, returns black color with max alpha value',
      () {
        Color testColor = const ui.Color.fromARGB(255, 230, 230, 230);

        Color inverseColor = sut.getInverseColor(testColor);

        expect(inverseColor, Colors.black);
      },
    );

    test(
      'on low rgb values (color is nearly black) of the passed color, returns white color with max alpha value',
      () {
        Color testColor = const ui.Color.fromARGB(255, 55, 55, 55);

        Color inverseColor = sut.getInverseColor(testColor);

        expect(inverseColor, Colors.white);
      },
    );
  });

  group('emitSuccessIfRequired', () {
    setUp(
      () {
        sut.pendingState = HomeState(
          status: Status.loading,
          imageModel: ImageModel(
            imageUrl: 'imageUrl',
            author: '',
            rawImage: mockImage,
            scaleFactor: .8,
          ),
          quoteModel: QuoteModel(
            quote: 'quote',
          ),
        );
        sut.previousState = HomeState(
          status: Status.success,
          imageModel: ImageModel(
            imageUrl: 'previousImageUrl',
            author: '',
            rawImage: mockImage,
            scaleFactor: .5,
          ),
          quoteModel: QuoteModel(
            quote: 'previousQuote',
          ),
        );
      },
    );

    blocTest(
      'on state status == loading, emits the pending state with success status, logs success message, and updates previousState to the successful one',
      build: () => sut,
      act: (cubit) => [
        sut.emit(
          const HomeState(status: Status.loading),
        ),
        sut.emitSuccessIfRequired(),
      ],
      expect: () => [
        const HomeState(status: Status.loading),
        sut.pendingState.copyWith(status: Status.success),
      ],
      verify: (cubit) => [
        verify(
          () => globalLogger.log(
            'success',
          ),
        ).called(1),
        expect(sut.previousState == sut.state, true),
      ],
    );

    blocTest(
      'on state status == decoding, emits the pending state with success status, logs success message, and updates previousState to the successful one',
      build: () => sut,
      act: (cubit) => [
        sut.emit(
          const HomeState(status: Status.decoding),
        ),
        sut.emitSuccessIfRequired(),
      ],
      expect: () => [
        const HomeState(status: Status.decoding),
        sut.pendingState.copyWith(status: Status.success),
      ],
      verify: (cubit) => [
        verify(
          () => globalLogger.log(
            'success',
          ),
        ).called(1),
        expect(sut.previousState == sut.state, true),
      ],
    );

    blocTest(
      'on state status != loading && status != decoding, does not emit the pending state with success status, does not log success message, and does not update previousState to the new one',
      build: () => sut,
      act: (cubit) => [
        sut.emit(
          const HomeState(status: Status.error),
        ),
        sut.emitSuccessIfRequired(),
      ],
      expect: () => [
        const HomeState(status: Status.error),
      ],
      verify: (cubit) => [
        verifyNever(
          () => globalLogger.log(
            'success',
          ),
        ),
        expect(sut.previousState != sut.state, true),
      ],
    );
  });

  group('emitSuccess', () {
    setUp(
      () {
        sut.pendingState = HomeState(
          status: Status.loading,
          imageModel: ImageModel(
            imageUrl: 'imageUrl',
            author: '',
            rawImage: mockImage,
            scaleFactor: .8,
          ),
          quoteModel: QuoteModel(
            quote: 'quote',
          ),
        );
      },
    );

    blocTest(
      'emits the pending state with success status, logs a success message',
      build: () => sut,
      act: (cubit) => sut.emitSuccess(),
      expect: () => [
        sut.pendingState.copyWith(status: Status.success),
      ],
      verify: (cubit) => globalLogger.log(
        'success',
      ),
    );
  });

  group('start', () {
    setUp(
      () {
        mockConnectivity = MockConnectivity();
        NetworkUtils.connectivity = mockConnectivity;
        mockImageLoader = MockImageLoader();
        mockImage = MockImage();
        when(
          () => mockImageLoader.loadImage(any()),
        ).thenAnswer((_) async {
          return mockImage;
        });
        when(() => mockImage.width).thenReturn(100);
        when(() => mockImage.height).thenReturn(200);

        sut.imageLoader = mockImageLoader;
      },
    );

    test(
      'on no network connection, no further interactions',
      () async {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer(
          (_) async => [ConnectivityResult.none],
        );

        sut.emit(
          const HomeState(status: Status.initial),
        );

        await sut.start();

        expect(
          sut.state,
          isA<HomeState>()
              .having(
                (state) => state.status,
                'status',
                Status.error,
              )
              .having(
                (state) => state.errorMessage,
                'errorMessage',
                'Check your network connection',
              ),
        );
      },
    );

    test(
      'on Status.initial reset old pendingStatus, then run getItemModels and loadImage regardless of results',
      () async {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer(
          (_) async => [ConnectivityResult.wifi],
        );
        when(
          () => imageRepository.getImageModel(),
        ).thenAnswer(
          (_) async => ImageModel(
            imageUrl: 'imageUrl',
            author: 'author',
          ),
        );
        when(
          () => quoteRepository.getQuoteModel(),
        ).thenAnswer(
          (_) async => QuoteModel(quote: 'quote'),
        );

        sut.emit(
          const HomeState(status: Status.initial),
        );

        await sut.start();

        verifyInOrder(
          [
            () => mockConnectivity.checkConnectivity(),
            () => globalLogger.log('Connection status: true'),
            () => globalLogger.log('pendingState reset'),
            () => imageRepository.getImageModel(),
            () => quoteRepository.getQuoteModel(),
            () => mockImageLoader.loadImage('imageUrl'),
            () => globalLogger.log('Width: 100, height: 200'),
          ],
        );
      },
    );

    test(
      'on Status.decoding reset pendingStatus, copy state to pendingState and loadImage',
      () async {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer(
          (_) async => [ConnectivityResult.wifi],
        );
        sut.emit(
          HomeState(
            status: Status.decoding,
            imageModel: ImageModel(
              imageUrl: 'imageUrl',
              author: 'author',
            ),
            quoteModel: QuoteModel(
              quote: 'quote',
            ),
          ),
        );

        await sut.start();

        verifyInOrder(
          [
            () => mockConnectivity.checkConnectivity(),
            () => globalLogger.log('pendingState reset'),
            () => sut.pendingState = sut.state,
            () => mockImageLoader.loadImage('imageUrl'),
            () => globalLogger.log('Width: 100, height: 200'),
          ],
        );
      },
    );

    HomeState stateA = const HomeState();
    HomeState stateB = const HomeState();

    blocTest(
      'on Status.loading, no further interaction',
      build: () => sut,
      seed: () => const HomeState(status: Status.loading),
      act: (cubit) async {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer(
          (_) async => [ConnectivityResult.wifi],
        );
        stateA = cubit.state;
        await cubit.start();
        stateB = cubit.state;
      },
      verify: (cubit) {
        expect(stateA == stateB, true);
      },
    );
  });

  group('handleStateUpdate', () {
    setUp(
      () {
        mockImage = MockImage();
        mockImageProvider = MockImageProvider();
        imageProvider = mockImageProvider;
        mockPaletteGeneratorService = MockPaletteGeneratorService();

        when(
          () => mockImage.width,
        ).thenReturn(100);
        when(() => mockImage.height).thenReturn(200);
      },
    );

    test(
      'executes the correct logic in the correct order and updates the state with the correct values and success status',
      () async {
        sut.paletteGeneratorService = mockPaletteGeneratorService;
        when(
          () => mockPaletteGeneratorService.generateColors(
            mockImageProvider,
            any(),
            any(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            const ui.Color.fromARGB(255, 0, 0, 0),
          ),
        );

        sut.emit(
          HomeState(
            status: Status.loading,
            imageModel: ImageModel(
              imageUrl: 'imageUrl',
              author: '',
              rawImage: mockImage,
            ),
            quoteModel: QuoteModel(
              quote: 'quote',
            ),
          ),
        );
        sut.pendingState = sut.state;

        await sut.handleStateUpdate(
          imageWidgetSize: const Size(100, 100),
          textPosition: const Offset(10, 10),
          textSize: const Size(50, 50),
        );

        expect(
          sut.state,
          isA<HomeState>()
              .having(
                (state) => state.status,
                'status',
                Status.success,
              )
              .having(
                (state) => state.imageModel!.imageUrl,
                'imageUrl',
                'imageUrl',
              )
              .having(
                (state) => state.imageModel!.rawImage,
                'rawImage',
                mockImage,
              )
              .having(
                (state) => state.imageModel!.scaleFactor,
                'scaleFactor',
                .5,
              )
              .having(
                (state) => state.quoteModel!.quote,
                'quote',
                'quote',
              )
              .having(
                (state) => state.quoteModel!.textPosition,
                'textPosition',
                const Offset(10.0, 10.0),
              )
              .having(
                (state) => state.quoteModel!.textSize,
                'textSize',
                const Size(50.0, 50.0),
              )
              .having(
                (state) => state.quoteModel!.textColor,
                'textColor',
                const ui.Color.fromARGB(255, 255, 255, 255),
              ),
        );

        verifyInOrder(
          [
            () => globalLogger.log('scaleFactor: 0.5'),
            () => globalLogger.log('layout randomized'),
            () => globalLogger.log('New textPosition: Offset(10.0, 10.0), new textSize: Size(50.0, 50.0)'),
            () => globalLogger.log('textColor = Color(0xffffffff)'),
            () => globalLogger.log('palette generated!'),
            () => globalLogger.log('success'),
          ],
        );
      },
    );
  });

  group('fromJson', () {
    test(
      'succesfully deserializes a json',
      () {
        final imageModelMap = {
          'ImageModelUrl': 'imageUrl',
          'ImageModelAuthor': 'author',
        };
        final quoteModelMap = {
          'QuoteModelUrl': 'quote',
        };
        final json = {
          'imageModel': imageModelMap,
          'quoteModel': quoteModelMap,
        };

        final HomeState? stateFromJson = sut.fromJson(json);

        expect(
          stateFromJson?.status,
          Status.decoding,
        );
        expect(
          stateFromJson?.imageModel,
          isA<ImageModel>()
              .having(
                (imageModel) => imageModel.author,
                'author',
                'author',
              )
              .having(
                (imageModel) => imageModel.imageUrl,
                'imageUrl',
                'imageUrl',
              ),
        );
        expect(
          stateFromJson?.quoteModel,
          isA<QuoteModel>().having(
            (quoteModel) => quoteModel.quote,
            'quote',
            'quote',
          ),
        );
      },
    );

    test(
      'on error logs the error and returns null',
      () {
        final json = {
          'imageModel': 'wrongData',
          'quoteModel': 'wrongData',
        };

        final HomeState? stateFromJson = sut.fromJson(json);

        expect(
          stateFromJson,
          null,
        );
        verify(
          () => globalLogger.log(
            any(
              that: contains(
                'Error on HomeState fromJson:',
              ),
            ),
          ),
        );
      },
    );
  });
}
