// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quotes_net_mittal_quote_remote_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuotesNetMittalResponse _$QuotesNetMittalResponseFromJson(
    Map<String, dynamic> json) {
  return _QuotesNetMittalResponse.fromJson(json);
}

/// @nodoc
mixin _$QuotesNetMittalResponse {
  @JsonKey(name: 'quoteText')
  String get quote => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;

  /// Serializes this QuotesNetMittalResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuotesNetMittalResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuotesNetMittalResponseCopyWith<QuotesNetMittalResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuotesNetMittalResponseCopyWith<$Res> {
  factory $QuotesNetMittalResponseCopyWith(QuotesNetMittalResponse value,
          $Res Function(QuotesNetMittalResponse) then) =
      _$QuotesNetMittalResponseCopyWithImpl<$Res, QuotesNetMittalResponse>;
  @useResult
  $Res call({@JsonKey(name: 'quoteText') String quote, String? author});
}

/// @nodoc
class _$QuotesNetMittalResponseCopyWithImpl<$Res,
        $Val extends QuotesNetMittalResponse>
    implements $QuotesNetMittalResponseCopyWith<$Res> {
  _$QuotesNetMittalResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuotesNetMittalResponse
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
abstract class _$$QuotesNetMittalResponseImplCopyWith<$Res>
    implements $QuotesNetMittalResponseCopyWith<$Res> {
  factory _$$QuotesNetMittalResponseImplCopyWith(
          _$QuotesNetMittalResponseImpl value,
          $Res Function(_$QuotesNetMittalResponseImpl) then) =
      __$$QuotesNetMittalResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'quoteText') String quote, String? author});
}

/// @nodoc
class __$$QuotesNetMittalResponseImplCopyWithImpl<$Res>
    extends _$QuotesNetMittalResponseCopyWithImpl<$Res,
        _$QuotesNetMittalResponseImpl>
    implements _$$QuotesNetMittalResponseImplCopyWith<$Res> {
  __$$QuotesNetMittalResponseImplCopyWithImpl(
      _$QuotesNetMittalResponseImpl _value,
      $Res Function(_$QuotesNetMittalResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuotesNetMittalResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quote = null,
    Object? author = freezed,
  }) {
    return _then(_$QuotesNetMittalResponseImpl(
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
class _$QuotesNetMittalResponseImpl implements _QuotesNetMittalResponse {
  _$QuotesNetMittalResponseImpl(
      {@JsonKey(name: 'quoteText') required this.quote, required this.author});

  factory _$QuotesNetMittalResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuotesNetMittalResponseImplFromJson(json);

  @override
  @JsonKey(name: 'quoteText')
  final String quote;
  @override
  final String? author;

  @override
  String toString() {
    return 'QuotesNetMittalResponse(quote: $quote, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuotesNetMittalResponseImpl &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quote, author);

  /// Create a copy of QuotesNetMittalResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuotesNetMittalResponseImplCopyWith<_$QuotesNetMittalResponseImpl>
      get copyWith => __$$QuotesNetMittalResponseImplCopyWithImpl<
          _$QuotesNetMittalResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuotesNetMittalResponseImplToJson(
      this,
    );
  }
}

abstract class _QuotesNetMittalResponse implements QuotesNetMittalResponse {
  factory _QuotesNetMittalResponse(
      {@JsonKey(name: 'quoteText') required final String quote,
      required final String? author}) = _$QuotesNetMittalResponseImpl;

  factory _QuotesNetMittalResponse.fromJson(Map<String, dynamic> json) =
      _$QuotesNetMittalResponseImpl.fromJson;

  @override
  @JsonKey(name: 'quoteText')
  String get quote;
  @override
  String? get author;

  /// Create a copy of QuotesNetMittalResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuotesNetMittalResponseImplCopyWith<_$QuotesNetMittalResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
