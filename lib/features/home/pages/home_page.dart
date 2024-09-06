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
            appBar: MediaQuery.of(context).orientation == Orientation.portrait
                ? AppBar(
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    title: Text(title),
                  )
                : null,
            drawer: const AppBarDrawer(index: 0),
            body: Row(
              children: [
                MediaQuery.of(context).orientation == Orientation.landscape ? const AppBarDrawer(index: 0) : const SizedBox.shrink(),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (imageModel != null && quoteModel != null)
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: _ImageDisplay(imageModel: imageModel),
                            ),
                            _QuoteDisplay(quoteModel: quoteModel),
                          ],
                        )
                      else
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                    ],
                  ),
                ),
              ],
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

class _ImageAuthorDisplay extends StatelessWidget {
  const _ImageAuthorDisplay({
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

final imageConstraints = BoxConstraints(
  maxHeight: (screenWidth * 7 / 8).roundToDouble(),
  maxWidth: (screenWidth * 7 / 8).roundToDouble(),
);

class _ImageDisplay extends StatelessWidget {
  const _ImageDisplay({
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
            return current.rawImage != null && current.status != Status.success || previous.status == Status.error && current.status != Status.success;
          },
          listener: (context, state) async {
            final imageWidgetSize = MediaQuery.of(_imageKey.currentContext!).size;
            context.read<HomeCubit>().calculateScaleFactor(imageWidgetSize);
            context.read<HomeCubit>().randomizeTextLayout();
            final RenderBox imageRenderBox = _imageKey.currentContext?.findRenderObject() as RenderBox;
            final RenderBox textRenderBox = _textKey.currentContext?.findRenderObject() as RenderBox;
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
              print('success');
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
                      key: _imageKey,
                      fit: state.rawImage != null && state.rawImage!.height < state.rawImage!.width ? BoxFit.fitHeight : BoxFit.fitWidth,
                    ),
                  ),
                ),
                _ImageAuthorDisplay(imageModel: imageModel),
              ],
            );
          },
        );
      },
    );
  }
}
