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
              -.3,
              .25,
            )
          : Offset(
              -.2,
              .1,
            ),
      child: OverflowBox(
        maxHeight: screenHeight.toDouble(),
        maxWidth: screenWidth.toDouble(),
        child: Icon(
          Quoteput.quoteput,
          size: MediaQuery.of(context).orientation == Orientation.portrait //R
              ? screenHeight / 1.6
              : screenHeight / 1.6,
          color: Theme.of(context).colorScheme.primary.withOpacity(.3),
        ),
      ),
    );
  }
}
