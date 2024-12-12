import 'dart:async';
import 'package:flutter/material.dart';

import 'package:palette_generator/palette_generator.dart';

class PaletteGeneratorService {
  final ImageProvider imageProvider;
  PaletteGeneratorService(
    this.imageProvider,
  );

  Future<Color> generateColors(
    Size scaledImageSize,
    Rect region,
  ) async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageProvider,
      size: scaledImageSize,
      region: region,
    );
    const placeholderColor = Colors.white;
    final paletteColor = paletteGenerator.dominantColor != null
        ? paletteGenerator.dominantColor!.color
        : paletteGenerator.vibrantColor != null
            ? paletteGenerator.vibrantColor!.color
            : placeholderColor;
    return paletteColor;
  }
}
