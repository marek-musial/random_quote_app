import 'package:flutter/material.dart';

extension Brightness on Color {
  bool isBright() {
    final double brightness = (red * 0.299 + green * 0.587 + blue * 0.114) / 255;
    if (brightness > .5) {
      return true;
    } else {
      return false;
    }
  }
}
