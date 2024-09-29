import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/injection_container.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/home/pages/home_page.dart';
import 'package:random_quote_app/features/about/about_page/about_page.dart';
import 'package:random_quote_app/features/root/cubit/root_cubit.dart';
import 'package:random_quote_app/features/settings/settings_page.dart';
import 'package:random_quote_app/features/sources/sources_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return getIt<HomeCubit>()..start();
        }),
        BlocProvider<RootCubit>(
          create: (context) {
            return getIt<RootCubit>();
          },
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<RootCubit, RootState>(
            builder: (context, rootState) {
              return MaterialApp(
                theme: ThemeData(
                  colorSchemeSeed: rootState.themeColor ?? homeState.quoteModel?.textColor ?? Colors.deepPurple,
                  brightness: rootState.isThemeBright ? Brightness.light : Brightness.dark,
                  useMaterial3: true,
                ),
                routes: {
                  '/': (context) => const HomePage(title: 'Random Quote App'),
                  '/about': (context) => const AboutPage(title: 'About page'),
                  '/sources': (context) => const SourcesPage(title: 'Data sources'),
                  '/settings': (context) => const SettingsPage(title: 'Settings'),
                },
                initialRoute: '/',
              );
            },
          );
        },
      ),
    );
  }
}
