part of 'home_cubit.dart';

class HomeState {
  const HomeState({
    this.status = Status.initial,
    this.errorMessage,
    this.imageModel,
    this.quoteModel,
    this.rawImage,
    this.textPosition,
    this.textSize,
    this.scaleFactor,
  });
  final Status status;
  final String? errorMessage;
  final ImageModel? imageModel;
  final QuoteModel? quoteModel;
  final ui.Image? rawImage;
  final Offset? textPosition;
  final Size? textSize;
  final double? scaleFactor;

  HomeState copyWith({
    Status? status,
    String? errorMessage,
    ImageModel? imageModel,
    QuoteModel? quoteModel,
    ui.Image? rawImage,
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
      textPosition: textPosition ?? this.textPosition,
      textSize: textSize ?? this.textSize,
      scaleFactor: scaleFactor ?? this.scaleFactor,
    );
  }
}
