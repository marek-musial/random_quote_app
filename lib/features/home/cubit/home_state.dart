part of 'home_cubit.dart';

class HomeState {
  const HomeState({
    this.status = Status.initial,
    this.errorMessage,
  });
  final Status status;
  final String? errorMessage;
}
