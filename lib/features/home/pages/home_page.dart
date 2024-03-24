import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
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
                padding: EdgeInsets.symmetric(horizontal: (screenWidth * 1 / 16).roundToDouble()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageModel != null && quoteModel != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              _ImageDisplay(
                                NetworkImage(imageModel.imageUrl),
                              ),
                              Padding(
                                padding: EdgeInsets.all((screenWidth * 1 / 16).roundToDouble()),
                                child: _QuoteDisplay(quoteModel: quoteModel),
                              ),
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

class _QuoteDisplay extends StatelessWidget {
  const _QuoteDisplay({
    required this.quoteModel,
  });

  final QuoteModel? quoteModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          quoteModel!.quote,
          style: TextStyle(
            fontSize: screenHeight / 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.end,
        ),
        Text(
          quoteModel!.author != null ? '~${quoteModel!.author}' : '',
          style: TextStyle(
            fontSize: screenHeight / 80,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}

class _ImageDisplay extends StatelessWidget {
  const _ImageDisplay(
    this.image,
  );

  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ((screenWidth * 7 / 8).roundToDouble()),
      width: ((screenWidth * 7 / 8).roundToDouble()),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
