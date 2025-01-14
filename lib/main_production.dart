import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_quote_app/app.dart';
import 'package:random_quote_app/core/config.dart';
import 'package:random_quote_app/core/directories.dart';
import 'package:random_quote_app/core/injection_container.dart';
import 'package:random_quote_app/firebase_options_production.dart';

void main() async {
  Config.appFlavor = Flavor.production;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: ProductionFirebaseOptions.currentPlatform,
  );
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  await initializeTempDirectory();
  cleanDirectory(tempDirectoryPath);
  configureDependencies();
  runApp(const MyApp());
}
