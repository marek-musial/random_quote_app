part of 'image_dialog_cubit.dart';

@freezed
class ImageDialogState with _$ImageDialogState {
  const ImageDialogState._();

  const factory ImageDialogState({
    String? fileSize,
    double? imageDimension,
    String? fileName,
  }) = _ImageDialogState;
}
