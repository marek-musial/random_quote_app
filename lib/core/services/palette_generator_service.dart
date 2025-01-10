import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PaletteGeneratorWrapper {
  Future<PaletteGenerator> fromImageProvider(
    ImageProvider imageProvider, {
    Size? size,
    Rect? region,
  }) {
    return PaletteGenerator.fromImageProvider(
      imageProvider,
      size: size,
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
    ImageProvider imageProvider,
    Size scaledImageSize,
    Rect region,
  ) async {
    final paletteGenerator = await wrapper.fromImageProvider(
      imageProvider,
      size: scaledImageSize,
      region: region,
    );

    const placeholderColor = Colors.white;
    return paletteGenerator.dominantColor?.color ?? //R
        paletteGenerator.vibrantColor?.color ??
        placeholderColor;
  }
}
