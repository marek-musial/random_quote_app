part of 'root_cubit.dart';

@immutable
class RootState {
  const RootState({
    this.isThemeBright = true,
  });
  final bool isThemeBright;

  RootState copyWith({
    final bool? isThemeBright,
  }) {
    return RootState(
      isThemeBright: isThemeBright ?? this.isThemeBright,
    );
  }
}
