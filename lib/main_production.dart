import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_quote_app/app.dart';
import 'package:random_quote_app/core/config.dart';
import 'package:random_quote_app/core/directories.dart';
import 'package:random_quote_app/core/injection_container.dart';

void main() async {
  Config.appFlavor = Flavor.production;
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await initializeTempDirectory();
  cleanDirectory(tempDirectoryPath);
  configureDependencies();
  runApp(const MyApp());
}