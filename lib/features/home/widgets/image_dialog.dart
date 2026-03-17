import 'dart:typed_data';
import 'dart:ui' as ui;

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
    final textEditingController = TextEditingController();
    const double startValue = 1080;

    Future<Uint8List?> captureBytes(double targetDimension) async {
      final context = widgetToImageKey.currentContext;
      if (context == null) return null;

      final boundary = context.findRenderObject()! as RenderRepaintBoundary;

      final scale = targetDimension / boundary.size.width;

      final image = await boundary.toImage(pixelRatio: scale);

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData?.buffer.asUint8List();
    }

    return BlocProvider(
      create: (context) => ImageDialogCubit()
        ..updateImageDimension(
          startValue,
        )
        ..updateFileSize(
          startValue.toInt(),
        ),
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
                          value: state.imageDimension ?? startValue,
                          onChanged: (double newValue) async {
                            context.read<ImageDialogCubit>().updateImageDimension(
                                  newValue.roundToDouble(),
                                );
                          },
                          onChangeEnd: (double? newValue) async {
                            final cubit = context.read<ImageDialogCubit>();
                            final dimension = newValue?.roundToDouble() ?? startValue;

                            final bytes = await captureBytes(dimension);

                            if (bytes != null) {
                              cubit.updateFileSize(bytes.length);
                            }
                          },
                          min: 300,
                          max: startValue,
                        ),
                        Text(
                          '${state.imageDimension?.toInt() ?? //R
                              startValue} x ${state.imageDimension?.toInt() ?? //R
                              startValue}',
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
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          final cubit = context.read<ImageDialogCubit>();
                          final bytes = await captureBytes(state.imageDimension ?? startValue);

                          if (bytes != null) {
                            cubit.capturePng(
                              bytes,
                              targetImageDimension: state.imageDimension,
                              fileName: state.fileName,
                            );
                          }

                          navigator.pop();
                        },
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          final cubit = context.read<ImageDialogCubit>();
                          final bytes = await captureBytes(state.imageDimension ?? startValue);

                          if (bytes != null) {
                            cubit.sharePng(
                              bytes,
                              targetImageDimension: state.imageDimension,
                              fileName: state.fileName,
                            );
                          }

                          navigator.pop();
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
