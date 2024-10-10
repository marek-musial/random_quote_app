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

void main() async {
  late Storage storage;
  late HomeCubit sut;
  late MockImageRepository imageRepository;
  late MockQuoteRepository quoteRepository;

  setUpAll(
    () {
      WidgetsFlutterBinding.ensureInitialized();
    },
  );

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
}
