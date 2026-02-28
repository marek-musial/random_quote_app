import 'package:flutter/material.dart';

extension Brightness on Color {
  bool isBright() {
    final double brightness = (r * 0.299 + g * 0.587 + b * 0.114);
    if (brightness > .5) {
      return true;
    } else {
      return false;
    }
  }
}

extension Inversion on Color {
  Color inverseColor() {
    if (r > 0.882 && g > 0.882 && b > 0.882) {
      return Colors.black;
    }

    if (r < 0.235 && g < 0.235 && b < 0.235) {
      return Colors.white;
    }

    return Color.from(
      red: 1 - r,
      green: 1 - g,
      blue: 1 - b,
      alpha: 1,
    );
  }
}
