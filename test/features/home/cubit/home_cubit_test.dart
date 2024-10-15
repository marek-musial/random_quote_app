import 'dart:ui' as ui;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/enums.dart';
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

class MockGalService extends Mock implements GalService {}

class MockRenderRepaintBoundary extends Mock implements RenderRepaintBoundary {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockNetworkImage';
  }
}

void main() async {
  late Storage storage;
  late HomeCubit sut;
  late MockImageRepository imageRepository;
  late MockQuoteRepository quoteRepository;
  late MockImage mockImage;
  late MockImageLoader mockImageLoader;

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
        verify: (cubit) => cubit.logger.log,
      );
    });

    group(
      'failure on getting quote model',
      () {
        setUp(() {
          when(() => quoteRepository.getQuoteModel()).thenThrow(
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
            const HomeState(status: Status.error, errorMessage: 'Exception: Error fetching quote'),
          ],
          verify: (cubit) => cubit.logger.log,
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
      'emits state with imageModel.rawImage when image loads successfully',
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
              'Failed to load image: Exception: Error loading image',
            ),
      ],
      verify: (cubit) => cubit.logger.log,
    );
    blocTest<HomeCubit, HomeState>(
      'emits error state when imageModel is null and logs the error',
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
              'An error occured while getting the image',
            ),
      ],
      verify: (cubit) => cubit.logger.log,
    );
  });

  group('randomizeTextLayout', () {
    test(
      'layout is randomized within range',
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
          inInclusiveRange(2, 9),
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
      },
    );

    test(
      'layout is not randomized due to decoding status',
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
      'gets passed pendingState textPosition and textSize',
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
      },
    );
  });

  group('calculateScaleFactor', () {
    setUp(() {
      mockImage = MockImage();
    });

    test(
      'calculates scaleFactor correctly',
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
              'scale factor calculation error',
            ),
      ],
      verify: (cubit) => cubit.logger.log,
    );
  });

  group('generateColors', () {
    mockImage = MockImage();
    mockImageLoader = MockImageLoader();
    MockPaletteGeneratorService mockPaletteGeneratorService = MockPaletteGeneratorService();
    MockImageProvider mockImageProvider = MockImageProvider();

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
      'generates color correctly',
      () async {
        imageProvider = mockImageProvider;

        when(
          () => mockPaletteGeneratorService.generateColors(any(), any()),
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
          () => mockPaletteGeneratorService.generateColors(any(), any()),
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
      verify: (cubit) => cubit.logger.log,
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
      verify: (cubit) => cubit.logger.log,
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
      'emits the pending state with success status',
      build: () => sut,
      act: (cubit) => sut.emitSuccess(),
      expect: () => [
        sut.pendingState.copyWith(status: Status.success),
      ],
    );
  });

  group('start', () {
    test(
      'on Status.initial reset old pendingStatus, then run getItemModels and loadImage regardless of results',
      () {
        sut.emit(
          const HomeState(status: Status.initial),
        );

        sut.start();

        verifyInOrder(
          [
            () => sut.resetPendingState(),
            () => sut.getItemModels(),
            () => sut.loadImage(),
          ],
        );
      },
    );

    test(
      'on Status.decoding reset pendingStatus, copy state to pendingState and loadImage',
      () {
        sut.emit(
          const HomeState(status: Status.decoding),
        );

        sut.start();

        verifyInOrder(
          [
            () => sut.resetPendingState(),
            () => sut.pendingState = sut.state,
            () => sut.loadImage(),
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
      act: (cubit) {
        stateA = cubit.state;
        cubit.start();
        stateB = cubit.state;
      },
      verify: (cubit) {
        stateA == stateB;
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
      'on error returns null',
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
      },
    );
  });

  group('capturePng', () {
    late MockGalService mockGalService;
    late MockRenderRepaintBoundary mockRenderRepaintBoundary;
    registerFallbackValue(RenderRepaintBoundary());
    setUp(
      () {
        mockGalService = MockGalService();
        mockRenderRepaintBoundary = MockRenderRepaintBoundary();
        mockImage = MockImage();
        sut.galService = mockGalService;
        when(
          () => mockRenderRepaintBoundary.size,
        ).thenReturn(
          const Size(100, 200),
        );
      },
    );

    test(
      'succesfully runs galService.capturePng',
      () async {
        when(() => sut.galService.capturePng(any())).thenAnswer((_) async {});

        await sut.capturePng(mockRenderRepaintBoundary);

        verify(
          () => sut.galService.capturePng(any()),
        );
      },
    );

    blocTest(
      'emits error state when capturing png fails and logs the error',
      build: () => sut,
      act: (cubit) async {
        when(
          () => mockGalService.capturePng(any()),
        ).thenThrow(
          Exception('Error on capturing image'),
        );

        await cubit.capturePng(mockRenderRepaintBoundary);
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
              'Exception: Error on capturing image',
            ),
      ],
      verify: (cubit) => cubit.logger.log,
    );
  });
}
