import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/theme/constraints.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/home/widgets/home_page_widgets_export.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({
    super.key,
    required this.imageModel,
  });

  final ImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        constraints = imageConstraints;
        return BlocConsumer<HomeCubit, HomeState>(
          listenWhen: (previous, current) {
            return current.imageModel?.rawImage != null && //R
                    current.status != Status.success ||
                previous.status == Status.error && //R
                    current.status != Status.success;
          },
          listener: (context, state) {
            final RenderObject? imageRenderObject = imageKey.currentContext?.findRenderObject();
            final RenderObject? textRenderObject = textKey.currentContext?.findRenderObject();

            final RenderBox imageRenderBox = imageRenderObject as RenderBox;
            final RenderBox textRenderBox = textRenderObject as RenderBox;

            final textPosition = imageRenderBox.globalToLocal(
              Offset(
                textRenderBox.localToGlobal(Offset.zero).dx,
                textRenderBox.localToGlobal(Offset.zero).dy,
              ),
            );

            context.read<HomeCubit>().handleStateUpdate(
                  imageWidgetSize: imageRenderObject.size,
                  textPosition: textPosition,
                  textSize: textRenderBox.size,
                );
          },
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
                      image: imageModel.rawImage,
                      key: imageKey,
                      fit: state.imageModel != null && //R
                              state.imageModel?.rawImage != null &&
                              state.imageModel!.rawImage!.height < state.imageModel!.rawImage!.width
                          ? BoxFit.fitHeight
                          : BoxFit.fitWidth,
                    ),
                  ),
                ),
                ImageAuthorDisplay(imageModel: imageModel),
              ],
            );
          },
        );
      },
    );
  }
}
