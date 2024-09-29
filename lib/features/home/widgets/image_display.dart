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
            return current.imageModel?.rawImage != null && current.status != Status.success ||
                previous.status == Status.error && current.status != Status.success;
          },
          listener: (context, state) async {
            final imageWidgetSize = MediaQuery.of(imageKey.currentContext!).size;
            context.read<HomeCubit>().calculateScaleFactor(imageWidgetSize);
            context.read<HomeCubit>().randomizeTextLayout();
            final RenderBox imageRenderBox = imageKey.currentContext?.findRenderObject() as RenderBox;
            final RenderBox textRenderBox = textKey.currentContext?.findRenderObject() as RenderBox;
            final textPosition = imageRenderBox.globalToLocal(
              Offset(
                textRenderBox.localToGlobal(Offset.zero).dx,
                textRenderBox.localToGlobal(Offset.zero).dy,
              ),
            );
            context.read<HomeCubit>().getTextPositionAndSize(
                  textPosition,
                  textRenderBox.size,
                );
            await context.read<HomeCubit>().generateColors();
            if ((state.status == Status.loading || state.status == Status.decoding) && context.mounted) {
              context.read<HomeCubit>().emitSuccess();
            }
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
                    child: Image.network(
                      imageModel.imageUrl,
                      key: imageKey,
                      fit: state.imageModel != null &&
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
