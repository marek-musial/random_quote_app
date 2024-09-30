import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/home/widgets/home_page_widgets_export.dart';

class ImageManagementDialog extends StatelessWidget {
  const ImageManagementDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'What do you want to do?',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          icon: const Icon(Icons.save_alt),
          label: const Text('Save'),
          onPressed: () {
            final RenderRepaintBoundary boundary = widgetToImageKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
            context.read<HomeCubit>().capturePng(boundary);
            Navigator.of(context).pop();
          },
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Back'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
