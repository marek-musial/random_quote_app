import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:random_quote_app/core/logger.dart';

String? tempDirectoryPath;
final Logger _directoryLogger = Logger();

Future<void> initializeTempDirectory() async {
  final Directory tempDirectory = await getTemporaryDirectory();
  tempDirectoryPath = tempDirectory.path;
  _directoryLogger.log('Temp directory initialized');
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
    _directoryLogger.log('Temp directory cleaned');
  } catch (e) {
    _directoryLogger.log(e.toString());
  }
}
