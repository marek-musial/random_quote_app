import 'dart:ui' as ui;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
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
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.getItemModels(),
        expect: () => [
          const HomeState(status: Status.loading),
          const HomeState(
            status: Status.error,
            errorMessage: 'Exception: Error fetching image',
          ),
        ],
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
          'emits Status.loading then Status.errorwith error message',
          build: () => sut,
          act: (cubit) => cubit.getItemModels(),
          expect: () => [
            const HomeState(status: Status.loading),
            const HomeState(status: Status.error, errorMessage: 'Exception: Error fetching quote'),
          ],
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
      'emits error state when image loading fails',
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
    );
    blocTest<HomeCubit, HomeState>(
      'emits error state when imageModel is null',
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
    );
  });

  group('randomizeTextLayout', () {
    test(
      'layout is randomized',
      () {
        sut.emit(const HomeState(status: Status.loading));
        sut.pendingState = HomeState(
          status: Status.loading,
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
}