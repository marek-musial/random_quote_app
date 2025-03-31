// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quotes_net_quotable_quote_remote_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuotesNetQuotableResponse _$QuotesNetQuotableResponseFromJson(
    Map<String, dynamic> json) {
  return _QuotesNetQuotableResponse.fromJson(json);
}

/// @nodoc
mixin _$QuotesNetQuotableResponse {
  @JsonKey(name: 'quoteText')
  String get quote => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;

  /// Serializes this QuotesNetQuotableResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuotesNetQuotableResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuotesNetQuotableResponseCopyWith<QuotesNetQuotableResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuotesNetQuotableResponseCopyWith<$Res> {
  factory $QuotesNetQuotableResponseCopyWith(QuotesNetQuotableResponse value,
          $Res Function(QuotesNetQuotableResponse) then) =
      _$QuotesNetQuotableResponseCopyWithImpl<$Res, QuotesNetQuotableResponse>;
  @useResult
  $Res call({@JsonKey(name: 'quoteText') String quote, String? author});
}

/// @nodoc
class _$QuotesNetQuotableResponseCopyWithImpl<$Res,
        $Val extends QuotesNetQuotableResponse>
    implements $QuotesNetQuotableResponseCopyWith<$Res> {
  _$QuotesNetQuotableResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuotesNetQuotableResponse
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
abstract class _$$QuotesNetQuotableResponseImplCopyWith<$Res>
    implements $QuotesNetQuotableResponseCopyWith<$Res> {
  factory _$$QuotesNetQuotableResponseImplCopyWith(
          _$QuotesNetQuotableResponseImpl value,
          $Res Function(_$QuotesNetQuotableResponseImpl) then) =
      __$$QuotesNetQuotableResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'quoteText') String quote, String? author});
}

/// @nodoc
class __$$QuotesNetQuotableResponseImplCopyWithImpl<$Res>
    extends _$QuotesNetQuotableResponseCopyWithImpl<$Res,
        _$QuotesNetQuotableResponseImpl>
    implements _$$QuotesNetQuotableResponseImplCopyWith<$Res> {
  __$$QuotesNetQuotableResponseImplCopyWithImpl(
      _$QuotesNetQuotableResponseImpl _value,
      $Res Function(_$QuotesNetQuotableResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuotesNetQuotableResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quote = null,
    Object? author = freezed,
  }) {
    return _then(_$QuotesNetQuotableResponseImpl(
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
class _$QuotesNetQuotableResponseImpl implements _QuotesNetQuotableResponse {
  _$QuotesNetQuotableResponseImpl(
      {@JsonKey(name: 'quoteText') required this.quote, required this.author});

  factory _$QuotesNetQuotableResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuotesNetQuotableResponseImplFromJson(json);

  @override
  @JsonKey(name: 'quoteText')
  final String quote;
  @override
  final String? author;

  @override
  String toString() {
    return 'QuotesNetQuotableResponse(quote: $quote, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuotesNetQuotableResponseImpl &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quote, author);

  /// Create a copy of QuotesNetQuotableResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuotesNetQuotableResponseImplCopyWith<_$QuotesNetQuotableResponseImpl>
      get copyWith => __$$QuotesNetQuotableResponseImplCopyWithImpl<
          _$QuotesNetQuotableResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuotesNetQuotableResponseImplToJson(
      this,
    );
  }
}

abstract class _QuotesNetQuotableResponse implements QuotesNetQuotableResponse {
  factory _QuotesNetQuotableResponse(
      {@JsonKey(name: 'quoteText') required final String quote,
      required final String? author}) = _$QuotesNetQuotableResponseImpl;

  factory _QuotesNetQuotableResponse.fromJson(Map<String, dynamic> json) =
      _$QuotesNetQuotableResponseImpl.fromJson;

  @override
  @JsonKey(name: 'quoteText')
  String get quote;
  @override
  String? get author;

  /// Create a copy of QuotesNetQuotableResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuotesNetQuotableResponseImplCopyWith<_$QuotesNetQuotableResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
