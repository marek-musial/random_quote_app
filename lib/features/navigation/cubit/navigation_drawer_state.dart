part of 'navigation_drawer_cubit.dart';

@freezed
class NavigationDrawerState with _$NavigationDrawerState {
  const factory NavigationDrawerState({
    @Default(0) int navigationIndex,
    @Default(false) bool isFeedbackMode,
  }) = _NavigationDrawerState;
}
