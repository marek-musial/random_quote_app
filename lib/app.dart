import 'package:flutter/material.dart';
import 'package:random_quote_app/features/home/pages/home_page.dart';
import 'package:random_quote_app/features/about/about_page/about_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
          return MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor:
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
}
