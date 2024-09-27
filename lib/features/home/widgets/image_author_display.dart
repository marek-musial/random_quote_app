import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/extensions.dart';
import 'package:random_quote_app/core/theme/constraints.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';

class ImageAuthorDisplay extends StatelessWidget {
  const ImageAuthorDisplay({super.key, 
    required this.imageModel,
  });

  final ImageModel? imageModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final imageModel = state.imageModel;
        if (imageModel != null) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: imageConstraints.maxHeight / 80,
            ),
            child: AnimatedOpacity(
              opacity: state.status == Status.success ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Text(
                imageModel.author != null ? 'Image author: ${imageModel.author}' : '',
                style: TextStyle(
                  fontSize: imageConstraints.maxHeight / 45,
                  color: state.textColor != null
                      ? state.textColor!.isBright()
                          ? Colors.white
                          : Colors.black
                      : Colors.black,
                ),
              ),
            ),
          );
        } else {
          return const Text('');
        }
      },
    );
  }
}
