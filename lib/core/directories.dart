import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:random_quote_app/core/logger.dart';

String? tempDirectoryPath;
final Logger _directoryLogger = Logger();

void initializeTempDirectory() async {
  final Directory tempDirectory = await getTemporaryDirectory();
  tempDirectoryPath = tempDirectory.path;
  _directoryLogger.log('Temp directory initialized');
}
