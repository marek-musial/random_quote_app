import 'package:flutter/material.dart';
import 'package:random_quote_app/core/assets/quoteput_icons.dart';
import 'package:random_quote_app/core/screen_sizes.dart';

class BackgroundIcon extends StatelessWidget {
  const BackgroundIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: MediaQuery.of(context).orientation == Orientation.portrait
          ? Offset(
              screenHeight / screenWidth * -.3,
              screenHeight / screenWidth * .1,
            )
          : Offset(
              screenWidth / screenHeight * -.25,
              screenWidth / screenHeight * .2,
            ),
      child: OverflowBox(
        maxHeight: screenHeight.toDouble(),
        maxWidth: screenWidth.toDouble(),
        child: Icon(
          Quoteput.quoteput,
          size: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight / screenWidth * 300 : screenHeight / screenWidth * 200,
          color: Theme.of(context).colorScheme.primary.withOpacity(.3),
        ),
      ),
    );
  }
}
