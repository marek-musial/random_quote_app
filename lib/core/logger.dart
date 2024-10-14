import 'dart:developer' as dev;

import 'package:injectable/injectable.dart';

@injectable
class Logger {
  Function loggingMethod = dev.log;

  void log(String message) {
    loggingMethod(message);
  }
}
