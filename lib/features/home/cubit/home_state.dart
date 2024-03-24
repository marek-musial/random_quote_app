part of 'home_cubit.dart';

class HomeState {
  const HomeState({
    this.status = Status.initial,
    this.errorMessage,
    this.imageModel,
    this.quoteModel,
  });
  final Status status;
  final String? errorMessage;
  final ImageModel? imageModel;
  final QuoteModel? quoteModel;
}
