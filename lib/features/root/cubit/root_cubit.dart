import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'root_state.dart';

@injectable
class RootCubit extends Cubit<RootState> {
  RootCubit() : super(const RootState());

  void toggleThemeBrightness() {
    emit(
      state.copyWith(
        isThemeBright: !state.isThemeBright,
      ),
    );
  }

  void setThemeColor(Color? color) {
    emit(
      RootState(
        themeColor: color,
      ).copyWith(
        isThemeBright: state.isThemeBright,
      ),
    );
  }
}
