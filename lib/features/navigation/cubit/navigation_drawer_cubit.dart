import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/core/logger.dart';

part 'navigation_drawer_state.dart';
part 'navigation_drawer_cubit.freezed.dart';

@injectable
class NavigationDrawerCubit extends Cubit<NavigationDrawerState> {
  NavigationDrawerCubit() : super(const NavigationDrawerState());

  void toggleFeedbackMode() {
    emit(
      state.copyWith(
        isFeedbackMode: !state.isFeedbackMode,
      ),
    );
  }

  void changeNavigationIndex(int newIndex) {
    emit(
      state.copyWith(
        navigationIndex: newIndex,
      ),
    );
    globalLogger.log('Page changed to: $newIndex');
  }
}
