import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/home/pages/home_page.dart';
import 'package:random_quote_app/features/about/about_page/about_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        ImageRepository(),
        QuoteRepository(),
      )..start(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor:
               state.textColor ?? 
               Colors.deepPurple),
              useMaterial3: true,
            ),
            routes: {
              '/': (context) => const HomePage(title: 'Random Quote App'),
              '/about': (context) => const AboutPage(title: 'About page'),
            },
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
