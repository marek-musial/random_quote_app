part of 'home_cubit.dart';

@Freezed(equal: true)
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @Default(Status.initial) Status status,
    @JsonKey(includeFromJson: false, includeToJson: false) String? errorMessage,
    ImageModel? imageModel,
    QuoteModel? quoteModel,
    CompositionModel? compositionModel,
  }) = _HomeState;

  factory HomeState.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$HomeStateFromJson(json);
}
