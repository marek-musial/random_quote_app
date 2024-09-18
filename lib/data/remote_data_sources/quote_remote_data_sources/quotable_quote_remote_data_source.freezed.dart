// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quotable_quote_remote_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuotableResponse _$QuotableResponseFromJson(Map<String, dynamic> json) {
  return _QuotableResponse.fromJson(json);
}

/// @nodoc
mixin _$QuotableResponse {
  String get content => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;

  /// Serializes this QuotableResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuotableResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuotableResponseCopyWith<QuotableResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuotableResponseCopyWith<$Res> {
  factory $QuotableResponseCopyWith(
          QuotableResponse value, $Res Function(QuotableResponse) then) =
      _$QuotableResponseCopyWithImpl<$Res, QuotableResponse>;
  @useResult
  $Res call({String content, String? author});
}

/// @nodoc
class _$QuotableResponseCopyWithImpl<$Res, $Val extends QuotableResponse>
    implements $QuotableResponseCopyWith<$Res> {
  _$QuotableResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuotableResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuotableResponseImplCopyWith<$Res>
    implements $QuotableResponseCopyWith<$Res> {
  factory _$$QuotableResponseImplCopyWith(_$QuotableResponseImpl value,
          $Res Function(_$QuotableResponseImpl) then) =
      __$$QuotableResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, String? author});
}

/// @nodoc
class __$$QuotableResponseImplCopyWithImpl<$Res>
    extends _$QuotableResponseCopyWithImpl<$Res, _$QuotableResponseImpl>
    implements _$$QuotableResponseImplCopyWith<$Res> {
  __$$QuotableResponseImplCopyWithImpl(_$QuotableResponseImpl _value,
      $Res Function(_$QuotableResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuotableResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? author = freezed,
  }) {
    return _then(_$QuotableResponseImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
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
class _$QuotableResponseImpl implements _QuotableResponse {
  _$QuotableResponseImpl({required this.content, required this.author});

  factory _$QuotableResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuotableResponseImplFromJson(json);

  @override
  final String content;
  @override
  final String? author;

  @override
  String toString() {
    return 'QuotableResponse(content: $content, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuotableResponseImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content, author);

  /// Create a copy of QuotableResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuotableResponseImplCopyWith<_$QuotableResponseImpl> get copyWith =>
      __$$QuotableResponseImplCopyWithImpl<_$QuotableResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuotableResponseImplToJson(
      this,
    );
  }
}

abstract class _QuotableResponse implements QuotableResponse {
  factory _QuotableResponse(
      {required final String content,
      required final String? author}) = _$QuotableResponseImpl;

  factory _QuotableResponse.fromJson(Map<String, dynamic> json) =
      _$QuotableResponseImpl.fromJson;

  @override
  String get content;
  @override
  String? get author;

  /// Create a copy of QuotableResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuotableResponseImplCopyWith<_$QuotableResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
