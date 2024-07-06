part of 'root_cubit.dart';

@immutable
class RootState {
  const RootState({
    this.themeColor,
    this.isThemeBright = true,
  });
  final Color? themeColor;
  final bool isThemeBright;

  RootState copyWith({
    final Color? themeColor,
    final bool? isThemeBright,
  }) {
    return RootState(
      themeColor: themeColor ?? this.themeColor,
      isThemeBright: isThemeBright ?? this.isThemeBright,
    );
  }
}
