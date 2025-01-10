import 'package:flutter/material.dart';
import 'package:random_quote_app/core/screen_sizes.dart';

final padding = EdgeInsets.symmetric(
  horizontal: screenHeight / 32,
  vertical: screenHeight / 64,
);

final border = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(screenWidth / 24),
  ),
);
