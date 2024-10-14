import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/features/root/cubit/root_cubit.dart';

class MockStorage extends Mock implements Storage {}

class MockRootCubit extends Mock implements RootCubit {}

class MockRootState extends Mock implements RootState {}

void main() async {
  late Storage storage;
  late RootCubit sut;
  late MockLogger logger = MockLogger();

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
}
