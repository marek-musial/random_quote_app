part of 'home_cubit.dart';

@Freezed(equal: true)
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @JsonKey(includeFromJson: false) @Default(Status.initial) Status status,
    @JsonKey(includeFromJson: false, includeToJson: false) String? errorMessage,
    ImageModel? imageModel,
    QuoteModel? quoteModel,
    @JsonKey(includeFromJson: false, includeToJson: false) ui.Image? rawImage,
    int? fontWeightIndex,
    int? textAlignmentIndex,
    int? mainAxisAlignmentIndex,
    int? crossAxisAlignmentIndex,
    @JsonKey(includeFromJson: false, includeToJson: false) Color? textColor,
    @JsonKey(includeFromJson: false, includeToJson: false) Offset? textPosition,
    @JsonKey(includeFromJson: false, includeToJson: false) Size? textSize,
    @JsonKey(includeFromJson: false, includeToJson: false) double? scaleFactor,
  }) = _HomeState;

  HomeState copyWithX({
    Status? status,
    String? errorMessage,
    ImageModel? imageModel,
    QuoteModel? quoteModel,
    ui.Image? rawImage,
    int? fontWeightIndex,
    int? textAlignmentIndex,
    int? mainAxisAlignmentIndex,
    int? crossAxisAlignmentIndex,
    Color? textColor,
    Offset? textPosition,
    Size? textSize,
    double? scaleFactor,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      imageModel: imageModel ?? this.imageModel,
      quoteModel: quoteModel ?? this.quoteModel,
      rawImage: rawImage ?? this.rawImage,
      fontWeightIndex: fontWeightIndex ?? this.fontWeightIndex,
      textAlignmentIndex: textAlignmentIndex ?? this.textAlignmentIndex,
      mainAxisAlignmentIndex: mainAxisAlignmentIndex ?? this.mainAxisAlignmentIndex,
      crossAxisAlignmentIndex: crossAxisAlignmentIndex ?? this.crossAxisAlignmentIndex,
      textColor: textColor ?? this.textColor,
      textPosition: textPosition ?? this.textPosition,
      textSize: textSize ?? this.textSize,
      scaleFactor: scaleFactor ?? this.scaleFactor,
    );
  }

  factory HomeState.fromJson(Map<String, dynamic> json) => _$HomeStateFromJson(json);
}
