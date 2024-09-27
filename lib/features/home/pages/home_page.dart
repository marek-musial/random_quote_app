import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/theme/constraints.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/home/widgets/home_page_widgets_export.dart';
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
                        Center(
                          child: ConstrainedBox(
                            constraints: imageConstraints,
                            child: InkWell(
                              child: RepaintBoundary(
                                key: widgetToImageKey,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ImageDisplay(imageModel: imageModel),
                                    QuoteDisplay(quoteModel: quoteModel),
                                  ],
                                ),
                              ),
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ImageManagementDialog();
                                  },
                                );
                              },
                            ),
                          ),
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
                if (state.status == Status.loading) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Another process in progress, please wait'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                } else {
                  context.read<HomeCubit>().start();
                }
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
