// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'picsum_image_remote_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PicsumResponse _$PicsumResponseFromJson(Map<String, dynamic> json) {
  return _PicsumResponse.fromJson(json);
}

/// @nodoc
mixin _$PicsumResponse {
  String get id => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;

  /// Serializes this PicsumResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PicsumResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PicsumResponseCopyWith<PicsumResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PicsumResponseCopyWith<$Res> {
  factory $PicsumResponseCopyWith(
          PicsumResponse value, $Res Function(PicsumResponse) then) =
      _$PicsumResponseCopyWithImpl<$Res, PicsumResponse>;
  @useResult
  $Res call({String id, String? author});
}

/// @nodoc
class _$PicsumResponseCopyWithImpl<$Res, $Val extends PicsumResponse>
    implements $PicsumResponseCopyWith<$Res> {
  _$PicsumResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PicsumResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PicsumResponseImplCopyWith<$Res>
    implements $PicsumResponseCopyWith<$Res> {
  factory _$$PicsumResponseImplCopyWith(_$PicsumResponseImpl value,
          $Res Function(_$PicsumResponseImpl) then) =
      __$$PicsumResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? author});
}

/// @nodoc
class __$$PicsumResponseImplCopyWithImpl<$Res>
    extends _$PicsumResponseCopyWithImpl<$Res, _$PicsumResponseImpl>
    implements _$$PicsumResponseImplCopyWith<$Res> {
  __$$PicsumResponseImplCopyWithImpl(
      _$PicsumResponseImpl _value, $Res Function(_$PicsumResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PicsumResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = freezed,
  }) {
    return _then(_$PicsumResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PicsumResponseImpl implements _PicsumResponse {
  _$PicsumResponseImpl({required this.id, required this.author});

  factory _$PicsumResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PicsumResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String? author;

  @override
  String toString() {
    return 'PicsumResponse(id: $id, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PicsumResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, author);

  /// Create a copy of PicsumResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PicsumResponseImplCopyWith<_$PicsumResponseImpl> get copyWith =>
      __$$PicsumResponseImplCopyWithImpl<_$PicsumResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PicsumResponseImplToJson(
      this,
    );
  }
}

abstract class _PicsumResponse implements PicsumResponse {
  factory _PicsumResponse(
      {required final String id,
      required final String? author}) = _$PicsumResponseImpl;

  factory _PicsumResponse.fromJson(Map<String, dynamic> json) =
      _$PicsumResponseImpl.fromJson;

  @override
  String get id;
  @override
  String? get author;

  /// Create a copy of PicsumResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PicsumResponseImplCopyWith<_$PicsumResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
