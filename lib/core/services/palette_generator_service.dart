import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:palette_generator/palette_generator.dart';

class PaletteGeneratorWrapper {
  Future<PaletteGenerator> fromImage(
    ui.Image image, {
    Size? size,
    Rect? region,
  }) {
    return PaletteGenerator.fromImage(
      image,
      region: region,
    );
  }
}

class PaletteGeneratorService {
  final PaletteGeneratorWrapper wrapper;

  PaletteGeneratorService({
    PaletteGeneratorWrapper? wrapper,
  }) : wrapper = wrapper ?? PaletteGeneratorWrapper();

  Future<Color> generateColors(
    ui.Image image,
    Size scaledImageSize,
    Rect region,
  ) async {
    final paletteGenerator = await wrapper.fromImage(
      image,
      size: scaledImageSize,
      region: region,
    );

    const placeholderColor = Colors.white;
    return paletteGenerator.dominantColor?.color ?? //R
        paletteGenerator.vibrantColor?.color ??
        placeholderColor;
  }
}
