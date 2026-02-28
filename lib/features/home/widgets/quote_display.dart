import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/extensions.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/core/theme/shadows.dart' as shadows;
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/home/models/composition_model.dart';

class QuoteDisplay extends StatelessWidget {
  const QuoteDisplay({super.key, required this.compositionModel});

  final CompositionModel? compositionModel;

  List<BoxShadow> getShadow() {
    final shadow = compositionModel != null
        ? compositionModel!.textColor != null
            ? compositionModel!.textColor!.isBright()
                ? [shadows.black]
                : [shadows.white]
            : [shadows.white]
        : [shadows.white];
    return shadow;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final quoteModel = state.quoteModel;
        final compositionModel = state.compositionModel;
        final FontWeight fontWeight = FontWeight.values[compositionModel?.fontWeightIndex ?? 1];
        final TextAlign textAlign = TextAlign.values[compositionModel?.textAlignmentIndex ?? 2];
        final String quoteText = quoteModel?.quote ?? '...';
        return Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: (screenWidth * 6 / 8).roundToDouble(),
              maxWidth: (screenWidth * 6 / 8).roundToDouble(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.values[compositionModel?.mainAxisAlignmentIndex ?? 2],
              crossAxisAlignment: CrossAxisAlignment.values[compositionModel?.crossAxisAlignmentIndex ?? 2],
              mainAxisSize: MainAxisSize.max,
              children: [
                AnimatedOpacity(
                  opacity: state.status == Status.success //R
                      ? 1.0
                      : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    // key: textKey,
                    quoteText,
                    style: TextStyle(
                      fontSize: compositionModel?.fontSize?.toDouble() ?? 16,
                      fontWeight: fontWeight,
                      color: compositionModel?.textColor,
                      shadows: getShadow(),
                    ),
                    textAlign: textAlign,
                  ),
                ),
                AnimatedOpacity(
                  opacity: state.status == Status.success //R
                      ? 1.0
                      : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    quoteModel!.author != null //R
                        ? '~${quoteModel.author}'
                        : '',
                    style: TextStyle(
                      fontSize: compositionModel?.authorFontSize?.toDouble() ?? 8,
                      fontWeight: fontWeight,
                      color: compositionModel?.textColor,
                      shadows: getShadow(),
                    ),
                    textAlign: textAlign,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
