import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(const RootState());

  void toggleThemeBrightness() {
    emit(
      state.copyWith(
        isThemeBright: !state.isThemeBright,
      ),
    );
  }
}
