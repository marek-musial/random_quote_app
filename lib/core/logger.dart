import 'dart:developer' as dev;

import 'package:injectable/injectable.dart';

@injectable
class Logger {
  void log(String message) {
    dev.log(message);
  }
}
