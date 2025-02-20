import 'package:feedback/feedback.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_quote_app/app.dart';
import 'package:random_quote_app/core/app_version.dart';
import 'package:random_quote_app/core/directories.dart';
import 'package:random_quote_app/core/injection_container.dart';
import 'package:random_quote_app/core/services/shared_preferences_service.dart';
import 'package:random_quote_app/core/theme/feedback_theme.dart';
import 'package:random_quote_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  await getAppVersion(build: 'dev');
  await initializeTempDirectory();
  cleanDirectory(tempDirectoryPath);
  configureDependencies();
  await SharedPreferencesService.init();
  runApp(
    BetterFeedback(
      theme: feedbackThemeData,
      child: const MyApp(),
    ),
  );
}
