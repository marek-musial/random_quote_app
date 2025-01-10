// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) {
  return _ImageModel.fromJson(json);
}

/// @nodoc
mixin _$ImageModel {
  @JsonKey(name: 'ImageModelUrl')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'ImageModelUrl')
  set imageUrl(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'ImageModelAuthor')
  String? get author => throw _privateConstructorUsedError;
  @JsonKey(name: 'ImageModelAuthor')
  set author(String? value) => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Image? get rawImage => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set rawImage(ui.Image? value) => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? get scaleFactor => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set scaleFactor(double? value) => throw _privateConstructorUsedError;

  /// Serializes this ImageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageModelCopyWith<ImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageModelCopyWith<$Res> {
  factory $ImageModelCopyWith(
          ImageModel value, $Res Function(ImageModel) then) =
      _$ImageModelCopyWithImpl<$Res, ImageModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'ImageModelUrl') String imageUrl,
      @JsonKey(name: 'ImageModelAuthor') String? author,
      @JsonKey(includeFromJson: false, includeToJson: false) ui.Image? rawImage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      double? scaleFactor});
}

/// @nodoc
class _$ImageModelCopyWithImpl<$Res, $Val extends ImageModel>
    implements $ImageModelCopyWith<$Res> {
  _$ImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? author = freezed,
    Object? rawImage = freezed,
    Object? scaleFactor = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      rawImage: freezed == rawImage
          ? _value.rawImage
          : rawImage // ignore: cast_nullable_to_non_nullable
              as ui.Image?,
      scaleFactor: freezed == scaleFactor
          ? _value.scaleFactor
          : scaleFactor // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageModelImplCopyWith<$Res>
    implements $ImageModelCopyWith<$Res> {
  factory _$$ImageModelImplCopyWith(
          _$ImageModelImpl value, $Res Function(_$ImageModelImpl) then) =
      __$$ImageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ImageModelUrl') String imageUrl,
      @JsonKey(name: 'ImageModelAuthor') String? author,
      @JsonKey(includeFromJson: false, includeToJson: false) ui.Image? rawImage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      double? scaleFactor});
}

/// @nodoc
class __$$ImageModelImplCopyWithImpl<$Res>
    extends _$ImageModelCopyWithImpl<$Res, _$ImageModelImpl>
    implements _$$ImageModelImplCopyWith<$Res> {
  __$$ImageModelImplCopyWithImpl(
      _$ImageModelImpl _value, $Res Function(_$ImageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? author = freezed,
    Object? rawImage = freezed,
    Object? scaleFactor = freezed,
  }) {
    return _then(_$ImageModelImpl(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      rawImage: freezed == rawImage
          ? _value.rawImage
          : rawImage // ignore: cast_nullable_to_non_nullable
              as ui.Image?,
      scaleFactor: freezed == scaleFactor
          ? _value.scaleFactor
          : scaleFactor // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageModelImpl implements _ImageModel {
  _$ImageModelImpl(
      {@JsonKey(name: 'ImageModelUrl') required this.imageUrl,
      @JsonKey(name: 'ImageModelAuthor') required this.author,
      @JsonKey(includeFromJson: false, includeToJson: false) this.rawImage,
      @JsonKey(includeFromJson: false, includeToJson: false) this.scaleFactor});

  factory _$ImageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageModelImplFromJson(json);

  @override
  @JsonKey(name: 'ImageModelUrl')
  String imageUrl;
  @override
  @JsonKey(name: 'ImageModelAuthor')
  String? author;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Image? rawImage;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? scaleFactor;

  @override
  String toString() {
    return 'ImageModel(imageUrl: $imageUrl, author: $author, rawImage: $rawImage, scaleFactor: $scaleFactor)';
  }

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageModelImplCopyWith<_$ImageModelImpl> get copyWith =>
      __$$ImageModelImplCopyWithImpl<_$ImageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageModelImplToJson(
      this,
    );
  }
}

abstract class _ImageModel implements ImageModel {
  factory _ImageModel(
      {@JsonKey(name: 'ImageModelUrl') required String imageUrl,
      @JsonKey(name: 'ImageModelAuthor') required String? author,
      @JsonKey(includeFromJson: false, includeToJson: false) ui.Image? rawImage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      double? scaleFactor}) = _$ImageModelImpl;

  factory _ImageModel.fromJson(Map<String, dynamic> json) =
      _$ImageModelImpl.fromJson;

  @override
  @JsonKey(name: 'ImageModelUrl')
  String get imageUrl;
  @JsonKey(name: 'ImageModelUrl')
  set imageUrl(String value);
  @override
  @JsonKey(name: 'ImageModelAuthor')
  String? get author;
  @JsonKey(name: 'ImageModelAuthor')
  set author(String? value);
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Image? get rawImage;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set rawImage(ui.Image? value);
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? get scaleFactor;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set scaleFactor(double? value);

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageModelImplCopyWith<_$ImageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
