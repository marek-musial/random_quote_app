import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/extensions.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/core/theme/shadows.dart' as shadows;
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/widgets/navigation_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) {
        return current.status == Status.error;
      },
      listener: (context, state) {
        final errorMessage = state.errorMessage ?? 'Unknown error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      builder: (context, state) {
        final imageModel = state.imageModel;
        final quoteModel = state.quoteModel;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.inversePrimary,
                Theme.of(context).colorScheme.primary,
              ],
              stops: const [.75, 1],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: const AppBarDrawer(index: 0),
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
                          AnimatedOpacity(
                            opacity: state.status == Status.success ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              imageModel.author != null ? 'Image author: ${imageModel.author}' : '',
                              style: TextStyle(
                                fontSize: screenHeight / 80,
                              ),
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
                context.read<HomeCubit>().start();
              },
              tooltip: 'Reroll',
              child: const Icon(Icons.refresh),
            ),
          ),
        );
      },
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
                AnimatedOpacity(
                  opacity: state.status == Status.success ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    key: _textKey,
                    quoteModel!.quote,
                    style: TextStyle(
                      fontSize: quoteModel!.quote.length < 160 ? screenHeight / 32 : screenHeight / 48,
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
                      fontSize: screenHeight / 60,
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
            return previous.rawImage == null && current.rawImage != null || previous.status == Status.error && current.status != Status.error;
          },
          listener: (context, state) {
            context.read<HomeCubit>().calculateScaleFactor(context);
            context.read<HomeCubit>().calculatePosition(
                  imageContext: _imageKey.currentContext,
                  textContext: _textKey.currentContext,
                );
            context.read<HomeCubit>().generateColors();
            if (state.status != Status.error) {
              context.read<HomeCubit>().emitSuccess();
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: AnimatedOpacity(
                opacity: state.status == Status.success ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Image.network(
                  imageModel.imageUrl,
                  key: _imageKey,
                  fit: state.rawImage != null && state.rawImage!.height < state.rawImage!.width ? BoxFit.fitHeight : BoxFit.fitWidth,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
