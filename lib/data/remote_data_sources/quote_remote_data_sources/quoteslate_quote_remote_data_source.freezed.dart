// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quoteslate_quote_remote_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuoteslateResponse _$QuoteslateResponseFromJson(Map<String, dynamic> json) {
  return _QuoteslateResponse.fromJson(json);
}

/// @nodoc
mixin _$QuoteslateResponse {
  String get quote => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;

  /// Serializes this QuoteslateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteslateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteslateResponseCopyWith<QuoteslateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteslateResponseCopyWith<$Res> {
  factory $QuoteslateResponseCopyWith(
          QuoteslateResponse value, $Res Function(QuoteslateResponse) then) =
      _$QuoteslateResponseCopyWithImpl<$Res, QuoteslateResponse>;
  @useResult
  $Res call({String quote, String? author});
}

/// @nodoc
class _$QuoteslateResponseCopyWithImpl<$Res, $Val extends QuoteslateResponse>
    implements $QuoteslateResponseCopyWith<$Res> {
  _$QuoteslateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteslateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quote = null,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      quote: null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuoteslateResponseImplCopyWith<$Res>
    implements $QuoteslateResponseCopyWith<$Res> {
  factory _$$QuoteslateResponseImplCopyWith(_$QuoteslateResponseImpl value,
          $Res Function(_$QuoteslateResponseImpl) then) =
      __$$QuoteslateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String quote, String? author});
}

/// @nodoc
class __$$QuoteslateResponseImplCopyWithImpl<$Res>
    extends _$QuoteslateResponseCopyWithImpl<$Res, _$QuoteslateResponseImpl>
    implements _$$QuoteslateResponseImplCopyWith<$Res> {
  __$$QuoteslateResponseImplCopyWithImpl(_$QuoteslateResponseImpl _value,
      $Res Function(_$QuoteslateResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuoteslateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quote = null,
    Object? author = freezed,
  }) {
    return _then(_$QuoteslateResponseImpl(
      quote: null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
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
class _$QuoteslateResponseImpl implements _QuoteslateResponse {
  _$QuoteslateResponseImpl({required this.quote, required this.author});

  factory _$QuoteslateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteslateResponseImplFromJson(json);

  @override
  final String quote;
  @override
  final String? author;

  @override
  String toString() {
    return 'QuoteslateResponse(quote: $quote, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteslateResponseImpl &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quote, author);

  /// Create a copy of QuoteslateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteslateResponseImplCopyWith<_$QuoteslateResponseImpl> get copyWith =>
      __$$QuoteslateResponseImplCopyWithImpl<_$QuoteslateResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteslateResponseImplToJson(
      this,
    );
  }
}

abstract class _QuoteslateResponse implements QuoteslateResponse {
  factory _QuoteslateResponse(
      {required final String quote,
      required final String? author}) = _$QuoteslateResponseImpl;

  factory _QuoteslateResponse.fromJson(Map<String, dynamic> json) =
      _$QuoteslateResponseImpl.fromJson;

  @override
  String get quote;
  @override
  String? get author;

  /// Create a copy of QuoteslateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteslateResponseImplCopyWith<_$QuoteslateResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
