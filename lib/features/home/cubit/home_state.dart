part of 'home_cubit.dart';

class HomeState {
  const HomeState({
    this.status = Status.initial,
    this.errorMessage,
    this.imageModel,
  });
  final Status status;
  final String? errorMessage;
  final ImageModel? imageModel;
}
