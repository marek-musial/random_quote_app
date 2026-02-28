import 'dart:ui' as ui;

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

class MockImage extends Mock implements ui.Image {}

void main() {
  late PaletteGeneratorService paletteGeneratorService;
  late MockPaletteGeneratorWrapper mockWrapper;
  late MockImage mockImage;

  setUp(() {
    mockWrapper = MockPaletteGeneratorWrapper();
    paletteGeneratorService = PaletteGeneratorService(wrapper: mockWrapper);
    mockImage = MockImage();
  });

  test(
    'returns dominantColor if available',
    () async {
      final mockPaletteGenerator = MockPaletteGenerator();
      when(() => mockPaletteGenerator.dominantColor).thenReturn(
        PaletteColor(Colors.red, 2),
      );

      when(
        () => mockWrapper.fromImage(
          mockImage,
          size: any(named: 'size'),
          region: any(named: 'region'),
        ),
      ).thenAnswer(
        (_) async => mockPaletteGenerator,
      );

      final color = await paletteGeneratorService.generateColors(
        mockImage,
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
        () => mockWrapper.fromImage(
          mockImage,
          size: any(named: 'size'),
          region: any(named: 'region'),
        ),
      ).thenAnswer(
        (_) async => mockPaletteGenerator,
      );

      final color = await paletteGeneratorService.generateColors(
        mockImage,
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
        () => mockWrapper.fromImage(
          mockImage,
          size: any(named: 'size'),
          region: any(named: 'region'),
        ),
      ).thenAnswer(
        (_) async => mockPaletteGenerator,
      );

      final color = await paletteGeneratorService.generateColors(
        mockImage,
        const Size(100, 100),
        const Rect.fromLTWH(0, 0, 50, 50),
      );

      expect(color, Colors.white);
    },
  );
}
