import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/theme/constraints.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/home/widgets/home_page_widgets_export.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: imageConstraints.maxWidth,
              height: imageConstraints.maxHeight,
              child: AnimatedOpacity(
                opacity: state.status == Status.success ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: RawImage(
                  image: state.compositionModel?.rawImage,
                  fit: state.compositionModel != null && //R
                          state.compositionModel?.rawImage != null &&
                          state.compositionModel!.rawImage!.height < state.compositionModel!.rawImage!.width
                      ? BoxFit.fitHeight
                      : BoxFit.fitWidth,
                ),
              ),
            ),
            ImageAuthorDisplay(imageModel: state.imageModel),
          ],
        );
      },
    );
  }
}
