import 'dart:io';

import 'package:path_provider/path_provider.dart';

String? tempDirectoryPath;

void initializeTempDirectory() async {
  final Directory tempDirectory = await getTemporaryDirectory();
  tempDirectoryPath = tempDirectory.path;
}
