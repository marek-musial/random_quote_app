// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pexels_image_remote_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PexelsResponse _$PexelsResponseFromJson(Map<String, dynamic> json) {
  return _PexelsResponse.fromJson(json);
}

/// @nodoc
mixin _$PexelsResponse {
  List<PexelsPhoto> get photos => throw _privateConstructorUsedError;

  /// Serializes this PexelsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PexelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PexelsResponseCopyWith<PexelsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PexelsResponseCopyWith<$Res> {
  factory $PexelsResponseCopyWith(
          PexelsResponse value, $Res Function(PexelsResponse) then) =
      _$PexelsResponseCopyWithImpl<$Res, PexelsResponse>;
  @useResult
  $Res call({List<PexelsPhoto> photos});
}

/// @nodoc
class _$PexelsResponseCopyWithImpl<$Res, $Val extends PexelsResponse>
    implements $PexelsResponseCopyWith<$Res> {
  _$PexelsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PexelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photos = null,
  }) {
    return _then(_value.copyWith(
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PexelsPhoto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PexelsResponseImplCopyWith<$Res>
    implements $PexelsResponseCopyWith<$Res> {
  factory _$$PexelsResponseImplCopyWith(_$PexelsResponseImpl value,
          $Res Function(_$PexelsResponseImpl) then) =
      __$$PexelsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PexelsPhoto> photos});
}

/// @nodoc
class __$$PexelsResponseImplCopyWithImpl<$Res>
    extends _$PexelsResponseCopyWithImpl<$Res, _$PexelsResponseImpl>
    implements _$$PexelsResponseImplCopyWith<$Res> {
  __$$PexelsResponseImplCopyWithImpl(
      _$PexelsResponseImpl _value, $Res Function(_$PexelsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PexelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photos = null,
  }) {
    return _then(_$PexelsResponseImpl(
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PexelsPhoto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PexelsResponseImpl implements _PexelsResponse {
  _$PexelsResponseImpl({required final List<PexelsPhoto> photos})
      : _photos = photos;

  factory _$PexelsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PexelsResponseImplFromJson(json);

  final List<PexelsPhoto> _photos;
  @override
  List<PexelsPhoto> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  String toString() {
    return 'PexelsResponse(photos: $photos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PexelsResponseImpl &&
            const DeepCollectionEquality().equals(other._photos, _photos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_photos));

  /// Create a copy of PexelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PexelsResponseImplCopyWith<_$PexelsResponseImpl> get copyWith =>
      __$$PexelsResponseImplCopyWithImpl<_$PexelsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PexelsResponseImplToJson(
      this,
    );
  }
}

abstract class _PexelsResponse implements PexelsResponse {
  factory _PexelsResponse({required final List<PexelsPhoto> photos}) =
      _$PexelsResponseImpl;

  factory _PexelsResponse.fromJson(Map<String, dynamic> json) =
      _$PexelsResponseImpl.fromJson;

  @override
  List<PexelsPhoto> get photos;

  /// Create a copy of PexelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PexelsResponseImplCopyWith<_$PexelsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PexelsPhoto _$PexelsPhotoFromJson(Map<String, dynamic> json) {
  return _PexelsPhoto.fromJson(json);
}

/// @nodoc
mixin _$PexelsPhoto {
  String? get photographer => throw _privateConstructorUsedError;
  @JsonKey(name: 'src')
  PexelsSizes get sizes => throw _privateConstructorUsedError;

  /// Serializes this PexelsPhoto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PexelsPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PexelsPhotoCopyWith<PexelsPhoto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PexelsPhotoCopyWith<$Res> {
  factory $PexelsPhotoCopyWith(
          PexelsPhoto value, $Res Function(PexelsPhoto) then) =
      _$PexelsPhotoCopyWithImpl<$Res, PexelsPhoto>;
  @useResult
  $Res call({String? photographer, @JsonKey(name: 'src') PexelsSizes sizes});

  $PexelsSizesCopyWith<$Res> get sizes;
}

/// @nodoc
class _$PexelsPhotoCopyWithImpl<$Res, $Val extends PexelsPhoto>
    implements $PexelsPhotoCopyWith<$Res> {
  _$PexelsPhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PexelsPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photographer = freezed,
    Object? sizes = null,
  }) {
    return _then(_value.copyWith(
      photographer: freezed == photographer
          ? _value.photographer
          : photographer // ignore: cast_nullable_to_non_nullable
              as String?,
      sizes: null == sizes
          ? _value.sizes
          : sizes // ignore: cast_nullable_to_non_nullable
              as PexelsSizes,
    ) as $Val);
  }

  /// Create a copy of PexelsPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PexelsSizesCopyWith<$Res> get sizes {
    return $PexelsSizesCopyWith<$Res>(_value.sizes, (value) {
      return _then(_value.copyWith(sizes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PexelsPhotoImplCopyWith<$Res>
    implements $PexelsPhotoCopyWith<$Res> {
  factory _$$PexelsPhotoImplCopyWith(
          _$PexelsPhotoImpl value, $Res Function(_$PexelsPhotoImpl) then) =
      __$$PexelsPhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? photographer, @JsonKey(name: 'src') PexelsSizes sizes});

  @override
  $PexelsSizesCopyWith<$Res> get sizes;
}

/// @nodoc
class __$$PexelsPhotoImplCopyWithImpl<$Res>
    extends _$PexelsPhotoCopyWithImpl<$Res, _$PexelsPhotoImpl>
    implements _$$PexelsPhotoImplCopyWith<$Res> {
  __$$PexelsPhotoImplCopyWithImpl(
      _$PexelsPhotoImpl _value, $Res Function(_$PexelsPhotoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PexelsPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photographer = freezed,
    Object? sizes = null,
  }) {
    return _then(_$PexelsPhotoImpl(
      photographer: freezed == photographer
          ? _value.photographer
          : photographer // ignore: cast_nullable_to_non_nullable
              as String?,
      sizes: null == sizes
          ? _value.sizes
          : sizes // ignore: cast_nullable_to_non_nullable
              as PexelsSizes,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PexelsPhotoImpl implements _PexelsPhoto {
  _$PexelsPhotoImpl(
      {required this.photographer, @JsonKey(name: 'src') required this.sizes});

  factory _$PexelsPhotoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PexelsPhotoImplFromJson(json);

  @override
  final String? photographer;
  @override
  @JsonKey(name: 'src')
  final PexelsSizes sizes;

  @override
  String toString() {
    return 'PexelsPhoto(photographer: $photographer, sizes: $sizes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PexelsPhotoImpl &&
            (identical(other.photographer, photographer) ||
                other.photographer == photographer) &&
            (identical(other.sizes, sizes) || other.sizes == sizes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, photographer, sizes);

  /// Create a copy of PexelsPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PexelsPhotoImplCopyWith<_$PexelsPhotoImpl> get copyWith =>
      __$$PexelsPhotoImplCopyWithImpl<_$PexelsPhotoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PexelsPhotoImplToJson(
      this,
    );
  }
}

abstract class _PexelsPhoto implements PexelsPhoto {
  factory _PexelsPhoto(
          {required final String? photographer,
          @JsonKey(name: 'src') required final PexelsSizes sizes}) =
      _$PexelsPhotoImpl;

  factory _PexelsPhoto.fromJson(Map<String, dynamic> json) =
      _$PexelsPhotoImpl.fromJson;

  @override
  String? get photographer;
  @override
  @JsonKey(name: 'src')
  PexelsSizes get sizes;

  /// Create a copy of PexelsPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PexelsPhotoImplCopyWith<_$PexelsPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PexelsSizes _$PexelsSizesFromJson(Map<String, dynamic> json) {
  return _PexelsSizes.fromJson(json);
}

/// @nodoc
mixin _$PexelsSizes {
  String get large => throw _privateConstructorUsedError;

  /// Serializes this PexelsSizes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PexelsSizes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PexelsSizesCopyWith<PexelsSizes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PexelsSizesCopyWith<$Res> {
  factory $PexelsSizesCopyWith(
          PexelsSizes value, $Res Function(PexelsSizes) then) =
      _$PexelsSizesCopyWithImpl<$Res, PexelsSizes>;
  @useResult
  $Res call({String large});
}

/// @nodoc
class _$PexelsSizesCopyWithImpl<$Res, $Val extends PexelsSizes>
    implements $PexelsSizesCopyWith<$Res> {
  _$PexelsSizesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PexelsSizes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? large = null,
  }) {
    return _then(_value.copyWith(
      large: null == large
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PexelsSizesImplCopyWith<$Res>
    implements $PexelsSizesCopyWith<$Res> {
  factory _$$PexelsSizesImplCopyWith(
          _$PexelsSizesImpl value, $Res Function(_$PexelsSizesImpl) then) =
      __$$PexelsSizesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String large});
}

/// @nodoc
class __$$PexelsSizesImplCopyWithImpl<$Res>
    extends _$PexelsSizesCopyWithImpl<$Res, _$PexelsSizesImpl>
    implements _$$PexelsSizesImplCopyWith<$Res> {
  __$$PexelsSizesImplCopyWithImpl(
      _$PexelsSizesImpl _value, $Res Function(_$PexelsSizesImpl) _then)
      : super(_value, _then);

  /// Create a copy of PexelsSizes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? large = null,
  }) {
    return _then(_$PexelsSizesImpl(
      large: null == large
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PexelsSizesImpl implements _PexelsSizes {
  _$PexelsSizesImpl({required this.large});

  factory _$PexelsSizesImpl.fromJson(Map<String, dynamic> json) =>
      _$$PexelsSizesImplFromJson(json);

  @override
  final String large;

  @override
  String toString() {
    return 'PexelsSizes(large: $large)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PexelsSizesImpl &&
            (identical(other.large, large) || other.large == large));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, large);

  /// Create a copy of PexelsSizes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PexelsSizesImplCopyWith<_$PexelsSizesImpl> get copyWith =>
      __$$PexelsSizesImplCopyWithImpl<_$PexelsSizesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PexelsSizesImplToJson(
      this,
    );
  }
}

abstract class _PexelsSizes implements PexelsSizes {
  factory _PexelsSizes({required final String large}) = _$PexelsSizesImpl;

  factory _PexelsSizes.fromJson(Map<String, dynamic> json) =
      _$PexelsSizesImpl.fromJson;

  @override
  String get large;

  /// Create a copy of PexelsSizes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PexelsSizesImplCopyWith<_$PexelsSizesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
