import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/network_utils.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/home/models/composition_model.dart';

class MockImageRepository extends Mock implements ImageRepository {}

class MockQuoteRepository extends Mock implements QuoteRepository {}

class MockStorage extends Mock implements Storage {}

class MockLogger extends Mock implements Logger {}

class MockConnectivity extends Mock implements Connectivity {}

class TestImageProvider extends ImageProvider<TestImageProvider> {
  final ui.Image image;
  final String url;

  TestImageProvider({required this.image, required this.url});

  @override
  Future<TestImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<TestImageProvider>(this);
  }

  @override
  String toString() => 'TestImageProvider($url)';
}

void main() async {
  late Storage storage;
  late HomeCubit sut;
  late MockImageRepository imageRepository;
  late MockQuoteRepository quoteRepository;

  WidgetsFlutterBinding.ensureInitialized();

  Future<ui.Image> createTestImage({
    int width = 100,
    int height = 100,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = Colors.blue;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      paint,
    );

    final picture = recorder.endRecording();
    return picture.toImage(width, height);
  }

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
      globalLogger = MockLogger();
      imageRepository = MockImageRepository();
      quoteRepository = MockQuoteRepository();
      sut = HomeCubit(imageRepository, quoteRepository);

      imageCache.clear();
      imageCache.clearLiveImages();
    },
  );

  Future<void> cacheTestImageForUrl(String url) async {
    final testImage = await createTestImage(width: 100, height: 100);
    imageCache.putIfAbsent(
      NetworkImage(url),
      () => OneFrameImageStreamCompleter(
        Future.value(ImageInfo(image: testImage)),
      ),
    );
  }

  group('ensureInitialized', () {
    group('on status success with hydrated state', () {
      setUp(() {
        sut.emit(
          HomeState(
            status: Status.success,
            imageModel: ImageModel(
              imageUrl: 'https://example.com/image.jpg',
              author: 'hydratedAuthor',
            ),
            quoteModel: QuoteModel(
              quote: 'hydratedQuote',
            ),
            compositionModel: CompositionModel(),
          ),
        );
      });

      blocTest<HomeCubit, HomeState>(
        'attempts to resume from hydrated state by reloading image',
        build: () => sut,
        act: (cubit) async {
          await cacheTestImageForUrl('https://example.com/image.jpg');

          when(() => imageRepository.getImageModel()).thenThrow(
            Exception('Should not be called'),
          );
          await cubit.ensureInitialized(const Size(100, 100));
        },
        expect: () => [
          isA<HomeState>().having(
            (state) => state.status,
            'status',
            Status.loading,
          ),
          isA<HomeState>().having(
            (state) => state.status,
            'status',
            Status.success,
          ),
        ],
        verify: (cubit) {
          verifyNever(() => imageRepository.getImageModel());
        },
      );
    });

    group('on status initial', () {
      setUp(() {
        when(() => imageRepository.getImageModel()).thenAnswer(
          (_) async => ImageModel(
            imageUrl: 'https://example.com/image.jpg',
            author: 'imageAuthor',
          ),
        );
        when(() => quoteRepository.getQuoteModel()).thenAnswer(
          (_) async => QuoteModel(
            quote: 'quote',
            author: 'quoteAuthor',
          ),
        );
      });

      blocTest<HomeCubit, HomeState>(
        'emits loading then success on successful data fetch',
        build: () => sut,
        act: (cubit) async {
          await cacheTestImageForUrl('https://example.com/image.jpg');

          final mockConnectivity = MockConnectivity();
          when(() => mockConnectivity.checkConnectivity()).thenAnswer(
            (_) async => [ConnectivityResult.wifi],
          );
          NetworkUtils.connectivity = mockConnectivity;

          await cubit.ensureInitialized(const Size(300, 500));
        },
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
                Status.success,
              )
              .having(
                (state) => state.imageModel?.imageUrl,
                'imageUrl',
                'https://example.com/image.jpg',
              )
              .having(
                (state) => state.quoteModel?.quote,
                'quote',
                'quote',
              ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits error on no network connection',
        build: () => sut,
        act: (cubit) async {
          await cacheTestImageForUrl('https://example.com/image.jpg');

          final mockConnectivity = MockConnectivity();
          when(() => mockConnectivity.checkConnectivity()).thenAnswer(
            (_) async => [ConnectivityResult.none],
          );
          NetworkUtils.connectivity = mockConnectivity;

          await cubit.ensureInitialized(const Size(300, 500));
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
                contains('Check your network connection'),
              ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits error state on image repository error',
        build: () => sut,
        act: (cubit) async {
          final mockConnectivity = MockConnectivity();
          when(() => mockConnectivity.checkConnectivity()).thenAnswer(
            (_) async => [ConnectivityResult.wifi],
          );
          NetworkUtils.connectivity = mockConnectivity;

          when(() => imageRepository.getImageModel()).thenThrow(
            Exception('Error fetching image'),
          );
          await cubit.ensureInitialized(const Size(300, 500));
        },
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
                Status.error,
              )
              .having(
                (state) => state.errorMessage,
                'errorMessage',
                contains('Error fetching image'),
              ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits error state on quote repository error',
        build: () => sut,
        act: (cubit) async {
          await cacheTestImageForUrl('https://example.com/image.jpg');

          final mockConnectivity = MockConnectivity();
          when(() => mockConnectivity.checkConnectivity()).thenAnswer(
            (_) async => [ConnectivityResult.wifi],
          );
          NetworkUtils.connectivity = mockConnectivity;

          when(() => quoteRepository.getQuoteModel()).thenThrow(
            Exception('Error fetching quote'),
          );
          await cubit.ensureInitialized(const Size(300, 500));
        },
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
                Status.error,
              )
              .having(
                (state) => state.errorMessage,
                'errorMessage',
                contains('Error fetching quote'),
              ),
        ],
      );
    });

    blocTest<HomeCubit, HomeState>(
      'returns early if already initialized on second call',
      build: () => sut,
      seed: () => const HomeState(status: Status.initial),
      act: (cubit) async {
        final mockConnectivity = MockConnectivity();
        when(() => mockConnectivity.checkConnectivity()).thenAnswer(
          (_) async => [ConnectivityResult.wifi],
        );
        NetworkUtils.connectivity = mockConnectivity;

        when(() => imageRepository.getImageModel()).thenAnswer(
          (_) async => ImageModel(
            imageUrl: 'https://example.com/image.jpg',
            author: 'author',
          ),
        );
        when(() => quoteRepository.getQuoteModel()).thenAnswer(
          (_) async => QuoteModel(quote: 'quote'),
        );
        // First initialization fails due to image loading, but sets _initialized to true
        await cubit.ensureInitialized(const Size(100, 100));
        // Second call should return early without calling repositories again
        await cubit.ensureInitialized(const Size(200, 200));
      },
      expect: () => [
        isA<HomeState>().having(
          (state) => state.status,
          'status',
          Status.loading,
        ),
        isA<HomeState>().having(
          (state) => state.status,
          'status',
          Status.error,
        ),
      ],
      verify: (cubit) {
        verify(() => imageRepository.getImageModel()).called(1);
      },
    );
  });

  group('serialization', () {
    test(
      'successfully deserializes valid json to HomeState',
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

        expect(stateFromJson, isNotNull);
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
      'logs error and returns null on deserializing invalid json',
      () {
        final json = {
          'imageModel': 'wrongData',
          'quoteModel': 'wrongData',
        };

        final HomeState? stateFromJson = sut.fromJson(json);

        expect(stateFromJson, null);
        verify(
          () => globalLogger.log(
            any(
              that: contains('Error restoring HomeState:'),
            ),
          ),
        );
      },
    );

    blocTest<HomeCubit, HomeState>(
      'serializes state to json and skips serialization if state unchanged',
      build: () => sut,
      act: (cubit) async {
        cubit.emit(
          HomeState(
            status: Status.success,
            imageModel: ImageModel(
              imageUrl: 'imageUrl',
              author: 'author',
            ),
            quoteModel: QuoteModel(
              quote: 'quote',
            ),
            compositionModel: CompositionModel(),
          ),
        );
      },
      expect: () => [
        isA<HomeState>()
            .having(
              (state) => state.status,
              'status',
              Status.success,
            )
            .having(
              (state) => state.imageModel?.imageUrl,
              'imageUrl',
              'imageUrl',
            ),
      ],
    );
  });

  group('calculateFontSize', () {
    setUp(() {
      sut.compositionModel = CompositionModel();
    });

    test('calculates font size for quotes <=20 chars', () {
      final quoteModel = QuoteModel(quote: 'Short');
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 10);
    });

    test('calculates font size for quotes <=160 chars', () {
      final quoteModel = QuoteModel(quote: 'a' * 100);
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 14);
    });

    test('calculates font size for quotes <=300 chars', () {
      final quoteModel = QuoteModel(quote: 'a' * 250);
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 20);
    });

    test('calculates font size for quotes <=540 chars', () {
      final quoteModel = QuoteModel(quote: 'a' * 400);
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 24);
    });

    test('calculates font size for quotes <=710 chars', () {
      final quoteModel = QuoteModel(quote: 'a' * 600);
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 28);
    });

    test('calculates font size for quotes <=900 chars', () {
      final quoteModel = QuoteModel(quote: 'a' * 800);
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 32);
    });

    test('calculates font size for quotes > 900 chars', () {
      final quoteModel = QuoteModel(quote: 'a' * 1000);
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 36);
    });

    test('calculates author font size for quote <=300 chars', () {
      final quoteModel = QuoteModel(
        quote: 'a' * 100,
        author: 'Some Author',
      );
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.authorFontSize, containerHeight ~/ 24);
    });

    test('calculates author font size for quote <=540 chars', () {
      final quoteModel = QuoteModel(
        quote: 'a' * 400,
        author: 'Some Author',
      );
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.authorFontSize, containerHeight ~/ 26);
    });

    test('calculates author font size for quote <=710 chars', () {
      final quoteModel = QuoteModel(
        quote: 'a' * 600,
        author: 'Some Author',
      );
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.authorFontSize, containerHeight ~/ 30);
    });

    test('calculates author font size for quote <=900 chars', () {
      final quoteModel = QuoteModel(
        quote: 'a' * 800,
        author: 'Some Author',
      );
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.authorFontSize, containerHeight ~/ 34);
    });

    test('calculates author font size for quote > 900 chars', () {
      final quoteModel = QuoteModel(
        quote: 'a' * 1000,
        author: 'Some Author',
      );
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.authorFontSize, containerHeight ~/ 38);
    });

    test('does not calculate author font size when author is null', () {
      final quoteModel = QuoteModel(
        quote: 'a' * 100,
        author: null,
      );
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.authorFontSize, isNull);
    });

    test('scales font sizes properly with different container heights', () {
      final quoteModel = QuoteModel(quote: 'Short');
      const smallContainer = 200.0;
      const largeContainer = 600.0;

      sut.calculateFontSize(smallContainer, quoteModel: quoteModel);
      final smallFontSize = sut.compositionModel?.fontSize;

      sut.calculateFontSize(largeContainer, quoteModel: quoteModel);
      final largeFontSize = sut.compositionModel?.fontSize;

      expect(largeFontSize, greaterThan(smallFontSize!));
      expect(largeFontSize, largeContainer ~/ 10);
    });

    test('handles zero quote length', () {
      final quoteModel = QuoteModel(quote: '');
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 10);
    });

    test('handles quote length exactly at boundary (20)', () {
      final quoteModel = QuoteModel(quote: 'a' * 20);
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 10);
    });

    test('handles quote length just over boundary (21)', () {
      final quoteModel = QuoteModel(quote: 'a' * 21);
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 14);
    });

    test('handles author length boundary 300', () {
      final quoteModel = QuoteModel(
        quote: 'a' * 300,
        author: 'Author',
      );
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.authorFontSize, containerHeight ~/ 24);
    });

    test('handles author length boundary 301', () {
      final quoteModel = QuoteModel(
        quote: 'a' * 301,
        author: 'Author',
      );
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.authorFontSize, containerHeight ~/ 26);
    });

    test('handles empty author string', () {
      final quoteModel = QuoteModel(
        quote: 'a' * 100,
        author: '',
      );
      const containerHeight = 400.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.authorFontSize, isNotNull);
    });

    test('handles very small container height', () {
      final quoteModel = QuoteModel(quote: 'Short');
      const containerHeight = 10.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 10);
      expect(sut.compositionModel?.fontSize, 1);
    });

    test('handles very large container height', () {
      final quoteModel = QuoteModel(quote: 'Short');
      const containerHeight = 10000.0;

      sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

      expect(sut.compositionModel?.fontSize, containerHeight ~/ 10);
      expect(sut.compositionModel?.fontSize, 1000);
    });
  });

  group('calculateTextPosition', () {
    test('calculates proper text position for all alignment combinations', () {
      const containerSize = Size(300.0, 500.0);
      const textSize = Size(100.0, 50.0);

      final expectedResults = {
        (0, 0): Offset(0, 0), // start, start
        (0, 1): Offset(containerSize.width - textSize.width, 0), // start, end
        (0, 2): Offset((containerSize.width - textSize.width) / 2, 0), // start, center
        (1, 0): Offset(0, containerSize.height - textSize.height), // end, start
        (1, 1): Offset(
          containerSize.width - textSize.width,
          containerSize.height - textSize.height,
        ), // end, end
        (1, 2): Offset(
          (containerSize.width - textSize.width) / 2,
          containerSize.height - textSize.height,
        ), // end, center
        (2, 0): Offset(
          0,
          (containerSize.height - textSize.height) / 2,
        ), // center, start
        (2, 1): Offset(
          containerSize.width - textSize.width,
          (containerSize.height - textSize.height) / 2,
        ), // center, end
        (2, 2): Offset(
          (containerSize.width - textSize.width) / 2,
          (containerSize.height - textSize.height) / 2,
        ), // center, center
      };

      for (int mainAxis = 0; mainAxis < 3; mainAxis++) {
        for (int crossAxis = 0; crossAxis < 3; crossAxis++) {
          final position = sut.calculateTextPosition(
            containerSize,
            textSize,
            mainAxis,
            crossAxis,
          );

          final expected = expectedResults[(mainAxis, crossAxis)]!;
          expect(position.dx, closeTo(expected.dx, 0.001));
          expect(position.dy, closeTo(expected.dy, 0.001));
        }
      }
    });

    test('handles null main- and crossAxisIndex and by defaulting to start-start alignment', () {
      const containerSize = Size(300.0, 500.0);
      const textSize = Size(100.0, 50.0);

      final position = sut.calculateTextPosition(
        containerSize,
        textSize,
        null, //should default to start
        null, //should default to start
      );

      expect(position, Offset(0, 0));
    });

    test('handles text larger than container gracefully', () {
      const containerSize = Size(100.0, 100.0);
      const textSize = Size(150.0, 150.0);

      final position = sut.calculateTextPosition(
        containerSize,
        textSize,
        1, //end
        1, //end
      );

      expect(position.dx, isNotNull);
      expect(position.dy, isNotNull);
    });

    test('handles zero-sized text', () {
      const containerSize = Size(300.0, 500.0);
      const textSize = Size(0.0, 0.0);

      final position = sut.calculateTextPosition(
        containerSize,
        textSize,
        1, //end
        1, //end
      );

      expect(position, Offset(containerSize.width, containerSize.height));
    });

    // Edge cases
    test('handles zero-sized container', () {
      const containerSize = Size(0.0, 0.0);
      const textSize = Size(100.0, 50.0);

      final position = sut.calculateTextPosition(
        containerSize,
        textSize,
        0, //start
        0, //start
      );

      expect(position, const Offset(0, 0));
    });

    test('handles large dimensions correctly', () {
      const containerSize = Size(2000.0, 3000.0);
      const textSize = Size(500.0, 400.0);

      final position = sut.calculateTextPosition(
        containerSize,
        textSize,
        2, //center
        2, //center
      );

      final expectedDx = (containerSize.width - textSize.width) / 2;
      final expectedDy = (containerSize.height - textSize.height) / 2;
      expect(position, Offset(expectedDx, expectedDy));
    });

    test('handles negative indices by defaulting to start', () {
      const containerSize = Size(300.0, 500.0);
      const textSize = Size(100.0, 50.0);

      final position = sut.calculateTextPosition(
        containerSize,
        textSize,
        -1, // Invalid index
        -1, // Invalid index
      );

      expect(position, const Offset(0, 0));
    });

    test('handles out-of-range indices by defaulting to start', () {
      const containerSize = Size(300.0, 500.0);
      const textSize = Size(100.0, 50.0);

      final position = sut.calculateTextPosition(
        containerSize,
        textSize,
        5, // Out of range
        5, // Out of range
      );

      expect(position, const Offset(0, 0));
    });

    test('handles fractional container dimensions', () {
      const containerSize = Size(333.33, 555.55);
      const textSize = Size(100.0, 50.0);

      final position = sut.calculateTextPosition(
        containerSize,
        textSize,
        2, // center
        2, // center
      );

      final expectedDx = (containerSize.width - textSize.width) / 2;
      final expectedDy = (containerSize.height - textSize.height) / 2;
      expect(position.dx, closeTo(expectedDx, 0.01));
      expect(position.dy, closeTo(expectedDy, 0.01));
    });

    test('handles fractional text dimensions', () {
      const containerSize = Size(300.0, 500.0);
      const textSize = Size(99.99, 49.99);

      final position = sut.calculateTextPosition(
        containerSize,
        textSize,
        1, // end
        1, // end
      );

      final expectedDx = containerSize.width - textSize.width;
      final expectedDy = containerSize.height - textSize.height;
      expect(position.dx, closeTo(expectedDx, 0.01));
      expect(position.dy, closeTo(expectedDy, 0.01));
    });

    test('provides expected container height divisor value for quote font size per quote length', () {
      const containerHeight = 400.0;

      //(quoteLength, expectedDivisor)
      final testCases = [
        (0, 10),
        (1, 10),
        (20, 10),
        (21, 14),
        (100, 14),
        (160, 14),
        (161, 20),
        (250, 20),
        (300, 20),
        (301, 24),
        (400, 24),
        (540, 24),
        (541, 28),
        (600, 28),
        (710, 28),
        (711, 32),
        (800, 32),
        (900, 32),
        (901, 36),
        (1000, 36),
      ];

      for (final (length, divisor) in testCases) {
        sut.compositionModel = CompositionModel();
        final quoteModel = QuoteModel(quote: 'a' * length);

        sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

        expect(
          sut.compositionModel?.fontSize,
          containerHeight ~/ divisor,
          reason: 'Quote length $length should use divisor $divisor for quote font size',
        );
      }
    });

    test('provides expected container height divisor value for author font size per quote length', () {
      const containerHeight = 400.0;

      //(quoteLength, expectedDivisor)
      final testCases = [
        (0, 24),
        (200, 24),
        (300, 24),
        (301, 26),
        (400, 26),
        (540, 26),
        (541, 30),
        (600, 30),
        (710, 30),
        (711, 34),
        (800, 34),
        (900, 34),
        (901, 38),
        (1000, 38),
      ];

      for (final (length, divisor) in testCases) {
        sut.compositionModel = CompositionModel();
        final quoteModel = QuoteModel(
          quote: 'a' * length,
          author: 'Author',
        );

        sut.calculateFontSize(containerHeight, quoteModel: quoteModel);

        expect(
          sut.compositionModel?.authorFontSize,
          containerHeight ~/ divisor,
          reason: 'Quote length $length should use author divisor $divisor for author font size',
        );
      }
    });
  });

  group('generateTextColor', () {
    setUp(() {
      sut.compositionModel = CompositionModel();
    });

    test('generates text color successfully from image palette', () async {
      final testImage = await createTestImage(width: 200, height: 200);

      sut.compositionModel?.rawImage = testImage;
      sut.compositionModel?.fontSize = 20;

      final quoteModel = QuoteModel(
        quote: 'This is a test quote',
        author: 'Test Author',
      );

      final mockConnectivity = MockConnectivity();
      when(() => mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async => [ConnectivityResult.wifi],
      );
      NetworkUtils.connectivity = mockConnectivity;

      await cacheTestImageForUrl('https://example.com/image.jpg');
      when(() => imageRepository.getImageModel()).thenAnswer(
        (_) async => ImageModel(
          imageUrl: 'https://example.com/image.jpg',
          author: 'author',
        ),
      );
      when(() => quoteRepository.getQuoteModel()).thenAnswer(
        (_) async => QuoteModel(quote: 'test'),
      );

      await sut.ensureInitialized(const Size(300, 500));

      final color = await sut.generateTextColor(
        quoteModel: quoteModel,
        compositionModel: sut.compositionModel!,
      );

      expect(color, isA<Color>());
      expect(color.a, 1);
    });

    test('handles quote for color generation', () async {
      final testImage = await createTestImage();
      sut.compositionModel?.rawImage = testImage;
      sut.compositionModel?.fontSize = 24;

      final quoteModel = QuoteModel(
        quote: 'a' * 500,
        author: 'Quote Author',
      );

      final mockConnectivity = MockConnectivity();
      when(() => mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async => [ConnectivityResult.wifi],
      );
      NetworkUtils.connectivity = mockConnectivity;

      await cacheTestImageForUrl('https://example.com/image.jpg');
      when(() => imageRepository.getImageModel()).thenAnswer(
        (_) async => ImageModel(
          imageUrl: 'https://example.com/image.jpg',
          author: 'author',
        ),
      );
      when(() => quoteRepository.getQuoteModel()).thenAnswer(
        (_) async => QuoteModel(quote: 'test'),
      );

      await sut.ensureInitialized(const Size(300, 400));

      final color = await sut.generateTextColor(
        quoteModel: quoteModel,
        compositionModel: sut.compositionModel!,
      );

      expect(color, isA<Color>());
    });
  });
}
