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
