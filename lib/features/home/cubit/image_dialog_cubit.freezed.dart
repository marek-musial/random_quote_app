// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_dialog_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageDialogState {
  String? get fileSize => throw _privateConstructorUsedError;
  double? get imageDimension => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;

  /// Create a copy of ImageDialogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageDialogStateCopyWith<ImageDialogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDialogStateCopyWith<$Res> {
  factory $ImageDialogStateCopyWith(
          ImageDialogState value, $Res Function(ImageDialogState) then) =
      _$ImageDialogStateCopyWithImpl<$Res, ImageDialogState>;
  @useResult
  $Res call({String? fileSize, double? imageDimension, String? fileName});
}

/// @nodoc
class _$ImageDialogStateCopyWithImpl<$Res, $Val extends ImageDialogState>
    implements $ImageDialogStateCopyWith<$Res> {
  _$ImageDialogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageDialogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileSize = freezed,
    Object? imageDimension = freezed,
    Object? fileName = freezed,
  }) {
    return _then(_value.copyWith(
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as String?,
      imageDimension: freezed == imageDimension
          ? _value.imageDimension
          : imageDimension // ignore: cast_nullable_to_non_nullable
              as double?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageDialogStateImplCopyWith<$Res>
    implements $ImageDialogStateCopyWith<$Res> {
  factory _$$ImageDialogStateImplCopyWith(_$ImageDialogStateImpl value,
          $Res Function(_$ImageDialogStateImpl) then) =
      __$$ImageDialogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? fileSize, double? imageDimension, String? fileName});
}

/// @nodoc
class __$$ImageDialogStateImplCopyWithImpl<$Res>
    extends _$ImageDialogStateCopyWithImpl<$Res, _$ImageDialogStateImpl>
    implements _$$ImageDialogStateImplCopyWith<$Res> {
  __$$ImageDialogStateImplCopyWithImpl(_$ImageDialogStateImpl _value,
      $Res Function(_$ImageDialogStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageDialogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileSize = freezed,
    Object? imageDimension = freezed,
    Object? fileName = freezed,
  }) {
    return _then(_$ImageDialogStateImpl(
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as String?,
      imageDimension: freezed == imageDimension
          ? _value.imageDimension
          : imageDimension // ignore: cast_nullable_to_non_nullable
              as double?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ImageDialogStateImpl extends _ImageDialogState {
  const _$ImageDialogStateImpl(
      {this.fileSize, this.imageDimension, this.fileName})
      : super._();

  @override
  final String? fileSize;
  @override
  final double? imageDimension;
  @override
  final String? fileName;

  @override
  String toString() {
    return 'ImageDialogState(fileSize: $fileSize, imageDimension: $imageDimension, fileName: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageDialogStateImpl &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.imageDimension, imageDimension) ||
                other.imageDimension == imageDimension) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fileSize, imageDimension, fileName);

  /// Create a copy of ImageDialogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageDialogStateImplCopyWith<_$ImageDialogStateImpl> get copyWith =>
      __$$ImageDialogStateImplCopyWithImpl<_$ImageDialogStateImpl>(
          this, _$identity);
}

abstract class _ImageDialogState extends ImageDialogState {
  const factory _ImageDialogState(
      {final String? fileSize,
      final double? imageDimension,
      final String? fileName}) = _$ImageDialogStateImpl;
  const _ImageDialogState._() : super._();

  @override
  String? get fileSize;
  @override
  double? get imageDimension;
  @override
  String? get fileName;

  /// Create a copy of ImageDialogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageDialogStateImplCopyWith<_$ImageDialogStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
