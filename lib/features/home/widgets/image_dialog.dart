import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/features/home/cubit/image_dialog_cubit.dart';
import 'package:random_quote_app/features/home/widgets/home_page_widgets_export.dart';

class ImageManagementDialog extends StatelessWidget {
  const ImageManagementDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RenderRepaintBoundary boundary = //R
        widgetToImageKey.currentContext!.findRenderObject()! //R
            as RenderRepaintBoundary;
    final textEditingController = TextEditingController();

    return BlocProvider(
      create: (context) => ImageDialogCubit(),
      child: BlocBuilder<ImageDialogCubit, ImageDialogState>(
        builder: (context, state) {
          return SimpleDialog(
            title: Text(
              'What do you want to do?',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (String value) {
                        context.read<ImageDialogCubit>().updateImageName(
                              value,
                            );
                      },
                      decoration: InputDecoration(
                        labelText: 'Image name (optional):',
                        isDense: true,
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenWidth / 64,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth / 20,
                      vertical: screenWidth / 64,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(6),
                      ),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    child: Column(
                      children: [
                        Text('Image dimensions:'),
                        Slider.adaptive(
                          value: state.imageDimension ?? boundary.size.width,
                          onChanged: (double newValue) async {
                            context.read<ImageDialogCubit>().updateImageDimension(
                                  newValue.roundToDouble(),
                                );
                          },
                          onChangeEnd: (double newValue) async {
                            await context.read<ImageDialogCubit>().updateFileSize(
                                  boundary,
                                  newValue.round(),
                                );
                          },
                          min: boundary.size.width,
                          max: 1080,
                        ),
                        Text(
                          '${state.imageDimension?.toInt() ?? //R
                              'W'} x ${state.imageDimension?.toInt() ?? //R
                              'H'}',
                        ),
                        Text(
                          'Estimated file size: ${state.fileSize ?? 'awaiting'}',
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        icon: const Icon(Icons.save_alt),
                        label: const Text('Save'),
                        onPressed: () {
                          context.read<ImageDialogCubit>().capturePng(
                                boundary,
                                targetImageDimension: state.imageDimension,
                                fileName: state.fileName,
                              );
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        onPressed: () {
                          context.read<ImageDialogCubit>().sharePng(
                                boundary,
                                targetImageDimension: state.imageDimension,
                                fileName: state.fileName,
                              );
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
