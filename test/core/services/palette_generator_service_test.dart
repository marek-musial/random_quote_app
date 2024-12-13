import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:random_quote_app/core/services/palette_generator_service.dart';

class MockPaletteGeneratorWrapper extends Mock implements PaletteGeneratorWrapper {}

class MockPaletteGenerator extends Mock implements PaletteGenerator {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockPaletteGenerator';
  }
}

class MockImageProvider extends Mock implements ImageProvider {}

void main() {
  late PaletteGeneratorService paletteGeneratorService;
  late MockPaletteGeneratorWrapper mockWrapper;
  late MockImageProvider mockImageProvider;

  setUp(() {
    mockWrapper = MockPaletteGeneratorWrapper();
    paletteGeneratorService = PaletteGeneratorService(wrapper: mockWrapper);
    mockImageProvider = MockImageProvider();
  });

  test(
    'returns dominantColor if available',
    () async {
      final mockPaletteGenerator = MockPaletteGenerator();
      when(() => mockPaletteGenerator.dominantColor).thenReturn(
        PaletteColor(Colors.red, 2),
      );

      when(
        () => mockWrapper.fromImageProvider(
          mockImageProvider,
          size: any(named: 'size'),
          region: any(named: 'region'),
        ),
      ).thenAnswer(
        (_) async => mockPaletteGenerator,
      );

      final color = await paletteGeneratorService.generateColors(
        mockImageProvider,
        const Size(100, 100),
        const Rect.fromLTWH(0, 0, 50, 50),
      );

      expect(color, Colors.red);
    },
  );

  test(
    'returns vibrantColor if dominantColor is not available',
    () async {
      final mockPaletteGenerator = MockPaletteGenerator();

      when(() => mockPaletteGenerator.dominantColor).thenReturn(null);
      when(() => mockPaletteGenerator.vibrantColor).thenReturn(
        PaletteColor(Colors.red, 2),
      );

      when(
        () => mockWrapper.fromImageProvider(
          mockImageProvider,
          size: any(named: 'size'),
          region: any(named: 'region'),
        ),
      ).thenAnswer(
        (_) async => mockPaletteGenerator,
      );

      final color = await paletteGeneratorService.generateColors(
        mockImageProvider,
        const Size(100, 100),
        const Rect.fromLTWH(0, 0, 50, 50),
      );

      expect(color, Colors.red);
    },
  );

  test(
    'returns placeholder color if no colors are available',
    () async {
      final mockPaletteGenerator = MockPaletteGenerator();
      when(() => mockPaletteGenerator.dominantColor).thenReturn(null);
      when(() => mockPaletteGenerator.vibrantColor).thenReturn(null);

      when(
        () => mockWrapper.fromImageProvider(
          mockImageProvider,
          size: any(named: 'size'),
          region: any(named: 'region'),
        ),
      ).thenAnswer(
        (_) async => mockPaletteGenerator,
      );

      final color = await paletteGeneratorService.generateColors(
        mockImageProvider,
        const Size(100, 100),
        const Rect.fromLTWH(0, 0, 50, 50),
      );

      expect(color, Colors.white);
    },
  );
}
