import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'root_state.dart';
part 'root_cubit.freezed.dart';
part 'root_cubit.g.dart';

@injectable
class RootCubit extends HydratedCubit<RootState> {
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
        themeColorValue: color?.value,
      ).copyWith(
        isThemeBright: state.isThemeBright,
      ),
    );
  }

  @override
  Map<String, dynamic>? toJson(RootState state) {
    final Map<String, dynamic> map = state.toJson();
    return map;
  }

  @override
  RootState? fromJson(Map<String, dynamic> json) {
    try {
      final jsonState = RootState.fromJson(json);
      return jsonState;
    } on Exception catch (e) {
      dev.log('Error on RootState fromJson: $e');
      return null;
    }
  }
}
