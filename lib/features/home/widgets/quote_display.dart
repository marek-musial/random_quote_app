import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/extensions.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/core/theme/constraints.dart';
import 'package:random_quote_app/core/theme/shadows.dart' as shadows;
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/home/widgets/home_page_widgets_export.dart';

class QuoteDisplay extends StatelessWidget {
  const QuoteDisplay({
    super.key,
    required this.quoteModel,
  });

  final QuoteModel? quoteModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final FontWeight fontWeight = FontWeight.values[state.fontWeightIndex ?? 1];
        final TextAlign textAlign = TextAlign.values[state.textAlignmentIndex ?? 2];
        return Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: (screenWidth * 6 / 8).roundToDouble(),
              maxWidth: (screenWidth * 6 / 8).roundToDouble(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.values[state.mainAxisAlignmentIndex ?? 2],
              crossAxisAlignment: CrossAxisAlignment.values[state.crossAxisAlignmentIndex ?? 2],
              mainAxisSize: MainAxisSize.max,
              children: [
                AnimatedOpacity(
                  opacity: state.status == Status.success ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    key: textKey,
                    quoteModel!.quote,
                    style: TextStyle(
                      fontSize: quoteModel!.quote.length < 300
                          ? quoteModel!.quote.length < 160
                              ? quoteModel!.quote.length <= 20
                                  ? imageConstraints.maxHeight / 10
                                  : imageConstraints.maxHeight / 14
                              : imageConstraints.maxHeight / 20
                          : imageConstraints.maxHeight / 24,
                      fontWeight: fontWeight,
                      color: state.textColor,
                      shadows: state.textColor != null
                          ? state.textColor!.isBright()
                              ? [shadows.black]
                              : [shadows.white]
                          : [shadows.white],
                    ),
                    textAlign: textAlign,
                  ),
                ),
                AnimatedOpacity(
                  opacity: state.status == Status.success ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    quoteModel!.author != null ? '~${quoteModel!.author}' : '',
                    style: TextStyle(
                      fontSize: imageConstraints.maxHeight / 24,
                      fontWeight: fontWeight,
                      color: state.textColor,
                      shadows: state.textColor != null
                          ? state.textColor!.isBright()
                              ? [shadows.black]
                              : [shadows.white]
                          : [shadows.white],
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
