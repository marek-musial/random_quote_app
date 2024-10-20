import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:random_quote_app/core/logger.dart';

String? tempDirectoryPath;

Future<void> initializeTempDirectory() async {
  final Directory tempDirectory = await getTemporaryDirectory();
  tempDirectoryPath = tempDirectory.path;
  globalLogger.log('Temp directory initialized');
}

void cleanDirectory(String? path) {
  try {
    final Directory directory = Directory('$path/');
    if (directory.existsSync()) {
      directory.listSync().forEach(
        (entity) {
          if (entity is File) {
            entity.deleteSync();
          } else if (entity is Directory) {
            entity.deleteSync(recursive: true);
          }
        },
      );
    }
    globalLogger.log('Temp directory cleaned');
  } catch (e) {
    globalLogger.log(e.toString());
  }
}
