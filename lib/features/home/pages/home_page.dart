import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        ImageRepository(),
        QuoteRepository(),
      )..start(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Unknown error';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final imageModel = state.imageModel;
          final quoteModel = state.quoteModel;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(title),
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (screenWidth * 1 / 16).roundToDouble(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageModel != null && quoteModel != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              _ImageDisplay(imageModel: imageModel),
                              _QuoteDisplay(quoteModel: quoteModel),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 128,
                          ),
                          Text(
                            imageModel.author != null ? 'Author: ${imageModel.author}' : '',
                            style: TextStyle(
                              fontSize: screenHeight / 80,
                            ),
                          ),
                        ],
                      )
                    else
                      const CircularProgressIndicator()
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<HomeCubit>().getItemModels();
              },
              tooltip: 'Reroll',
              child: const Icon(Icons.refresh),
            ),
          );
        },
      ),
    );
  }
}

final _imageKey = GlobalKey();
final _textKey = GlobalKey();

class _QuoteDisplay extends StatelessWidget {
  const _QuoteDisplay({
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
            margin: EdgeInsets.all((screenWidth * 1 / 16).roundToDouble()),
            constraints: BoxConstraints(
              maxHeight: (screenWidth * 6 / 8).roundToDouble(),
              maxWidth: (screenWidth * 6 / 8).roundToDouble(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.values[state.mainAxisAlignmentIndex ?? 2],
              crossAxisAlignment: CrossAxisAlignment.values[state.crossAxisAlignmentIndex ?? 2],
              mainAxisSize: MainAxisSize.max,
          children: [
            Text(
                  key: _textKey,
              quoteModel!.quote,
              style: TextStyle(
                    fontSize: quoteModel!.quote.length < 170 ? screenHeight / 32 : screenHeight / 48,
                    fontWeight: fontWeight,
                color: state.textColor,
              ),
                  textAlign: textAlign,
            ),
            Text(
              quoteModel!.author != null ? '~${quoteModel!.author}' : '',
              style: TextStyle(
                fontSize: screenHeight / 80,
                    fontWeight: fontWeight,
                color: state.textColor,
              ),
                  textAlign: textAlign,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ImageDisplay extends StatelessWidget {
  const _ImageDisplay({
    required this.imageModel,
  });

  final ImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        constraints = BoxConstraints(
          maxHeight: (screenWidth * 7 / 8).roundToDouble(),
          maxWidth: (screenWidth * 7 / 8).roundToDouble(),
        );
        return BlocConsumer<HomeCubit, HomeState>(
          listenWhen: (previous, current) {
            return previous.rawImage == null && current.rawImage != null;
          },
          listener: (context, state) {
            context.read<HomeCubit>().calculateScaleFactor(context);
            context.read<HomeCubit>().calculatePosition(
                  imageContext: _imageKey.currentContext,
                  textContext: _textKey.currentContext,
                );
            context.read<HomeCubit>().generateColors();
            context.read<HomeCubit>().emitSuccess();
          },
          builder: (context, state) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Image.network(
                imageModel.imageUrl,
                key: _imageKey,
                fit: state.rawImage != null && state.rawImage!.height < state.rawImage!.width ? BoxFit.fitHeight : BoxFit.fitWidth,
              ),
            );
          },
        );
      },
    );
  }
}
