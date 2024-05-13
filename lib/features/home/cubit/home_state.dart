part of 'home_cubit.dart';

class HomeState {
  const HomeState({
    this.status = Status.initial,
    this.errorMessage,
    this.imageModel,
    this.quoteModel,
    this.rawImage,
  });
  final Status status;
  final String? errorMessage;
  final ImageModel? imageModel;
  final QuoteModel? quoteModel;
  final ui.Image? rawImage;

  HomeState copyWith({
    Status? status,
    String? errorMessage,
    ImageModel? imageModel,
    QuoteModel? quoteModel,
    ui.Image? rawImage,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      imageModel: imageModel ?? this.imageModel,
      quoteModel: quoteModel ?? this.quoteModel,
      rawImage: rawImage ?? this.rawImage,
    );
  }
}
