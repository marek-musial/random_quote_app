import 'dart:developer' as dev;

import 'package:injectable/injectable.dart';

@injectable
class Logger {
  void logError(String message) {
    dev.log(message);
  }
}
