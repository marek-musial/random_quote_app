part of 'navigation_drawer_cubit.dart';

@Freezed(equal: true)
class NavigationDrawerState with _$NavigationDrawerState {
  const factory NavigationDrawerState({
    @Default(0) int navigationIndex,
  }) = _NavigationDrawerState;
}
