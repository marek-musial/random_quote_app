part of 'root_cubit.dart';

@freezed
class RootState with _$RootState {
  const factory RootState({
    int? themeColorValue,
    @Default(true) bool isThemeBright,
  }) = _RootState;
  
  factory RootState.fromJson(Map<String, dynamic> json) => _$RootStateFromJson(json);
}
