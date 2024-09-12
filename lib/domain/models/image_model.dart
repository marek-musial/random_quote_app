import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';
part 'image_model.g.dart';

@unfreezed
class ImageModel with _$ImageModel {
  factory ImageModel({
    @JsonKey(name: 'ImageModelUrl') required String imageUrl,
    @JsonKey(name: 'ImageModelAuthor') required String? author,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);
}
