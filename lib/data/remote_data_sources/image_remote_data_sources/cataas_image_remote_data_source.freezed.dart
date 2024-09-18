// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cataas_image_remote_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CataasResponse _$CataasResponseFromJson(Map<String, dynamic> json) {
  return _CataasResponse.fromJson(json);
}

/// @nodoc
mixin _$CataasResponse {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;

  /// Serializes this CataasResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CataasResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CataasResponseCopyWith<CataasResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CataasResponseCopyWith<$Res> {
  factory $CataasResponseCopyWith(
          CataasResponse value, $Res Function(CataasResponse) then) =
      _$CataasResponseCopyWithImpl<$Res, CataasResponse>;
  @useResult
  $Res call({@JsonKey(name: '_id') String id});
}

/// @nodoc
class _$CataasResponseCopyWithImpl<$Res, $Val extends CataasResponse>
    implements $CataasResponseCopyWith<$Res> {
  _$CataasResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CataasResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CataasResponseImplCopyWith<$Res>
    implements $CataasResponseCopyWith<$Res> {
  factory _$$CataasResponseImplCopyWith(_$CataasResponseImpl value,
          $Res Function(_$CataasResponseImpl) then) =
      __$$CataasResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id});
}

/// @nodoc
class __$$CataasResponseImplCopyWithImpl<$Res>
    extends _$CataasResponseCopyWithImpl<$Res, _$CataasResponseImpl>
    implements _$$CataasResponseImplCopyWith<$Res> {
  __$$CataasResponseImplCopyWithImpl(
      _$CataasResponseImpl _value, $Res Function(_$CataasResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CataasResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$CataasResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CataasResponseImpl implements _CataasResponse {
  _$CataasResponseImpl({@JsonKey(name: '_id') required this.id});

  factory _$CataasResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CataasResponseImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;

  @override
  String toString() {
    return 'CataasResponse(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CataasResponseImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of CataasResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CataasResponseImplCopyWith<_$CataasResponseImpl> get copyWith =>
      __$$CataasResponseImplCopyWithImpl<_$CataasResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CataasResponseImplToJson(
      this,
    );
  }
}

abstract class _CataasResponse implements CataasResponse {
  factory _CataasResponse({@JsonKey(name: '_id') required final String id}) =
      _$CataasResponseImpl;

  factory _CataasResponse.fromJson(Map<String, dynamic> json) =
      _$CataasResponseImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;

  /// Create a copy of CataasResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CataasResponseImplCopyWith<_$CataasResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
