import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/features/root/cubit/root_cubit.dart';

class MockStorage extends Mock implements Storage {}

class MockRootCubit extends Mock implements RootCubit {}

class MockRootState extends Mock implements RootState {}

class MockLogger extends Mock implements Logger {}

void main() async {
  late Storage storage;
  late RootCubit sut;
  globalLogger = MockLogger();

  void initHydratedStorage() {
    storage = MockStorage();
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  }

  setUp(
    () {
      initHydratedStorage();
      sut = RootCubit();
    },
  );

  group('toggleThemeBrightness', () {
    blocTest(
      'emits state with opposite bool isThemeBright and the same themeColorValue',
      build: () => sut,
      seed: () => const RootState(
        isThemeBright: true,
        themeColorValue: 1,
      ),
      act: (cubit) => cubit.toggleThemeBrightness(),
      expect: () => [
        const RootState(
          isThemeBright: false,
          themeColorValue: 1,
        ),
      ],
    );
  });

  group('setThemeColor', () {
    late Color themeColor;
    setUp(() {
      themeColor = const Color.fromARGB(255, 150, 50, 100);
    });
    blocTest(
      'description',
      build: () => sut,
      seed: () => RootState(
        themeColorValue: const Color.fromARGB(255, 100, 150, 150).value,
        isThemeBright: true,
      ),
      act: (cubit) => cubit.setThemeColor(themeColor),
      expect: () => [
        RootState(
          themeColorValue: themeColor.value,
          isThemeBright: true,
        ),
      ],
    );
  });

  group('fromJson', () {
    test('returns a RootState from json', () {
      Map<String, dynamic> json = {
        'themeColorValue': 1,
        'isThemeBright': true,
      };

      RootState? stateFromJson = sut.fromJson(json);

      expect(
        stateFromJson,
        const RootState(
          themeColorValue: 1,
          isThemeBright: true,
        ),
      );
    });

    test(
      'on error throws and logs the error, then does nothing',
      () {
        Map<String, dynamic> invalidJson = {
          "themeColorValue": "invalid_value",
        };
        RootState? stateFromJson;

        stateFromJson = sut.fromJson(invalidJson);

        expect(stateFromJson, null);
        verify(
          () => globalLogger.log(
            any(
              that: contains(
                'Error on RootState fromJson:',
              ),
            ),
          ),
        ).called(1);
      },
    );
  });
}
