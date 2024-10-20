import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';

class MockLoggingMethod extends Mock {
  void call(String message);
}

void main() {
  final logger = Logger();
  group('Logger', () {
    test('logs message using the provided logging method', () {
      String message = 'message';
      MockLoggingMethod mockLoggingMethod = MockLoggingMethod();
      when(
        () => mockLoggingMethod(any()),
      ).thenAnswer(
        (_) {},
      );
      logger.loggingMethod = mockLoggingMethod.call;

      logger.log(message);

      verify(
        () => mockLoggingMethod.call(
          any(
            that: contains(message),
          ),
        ),
      ).called(1);
    });
  });
}
