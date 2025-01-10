// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'affirmations_quote_remote_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AffirmationsResponse _$AffirmationsResponseFromJson(Map<String, dynamic> json) {
  return _AffirmationsResponse.fromJson(json);
}

/// @nodoc
mixin _$AffirmationsResponse {
  String get affirmation => throw _privateConstructorUsedError;

  /// Serializes this AffirmationsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AffirmationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AffirmationsResponseCopyWith<AffirmationsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AffirmationsResponseCopyWith<$Res> {
  factory $AffirmationsResponseCopyWith(AffirmationsResponse value,
          $Res Function(AffirmationsResponse) then) =
      _$AffirmationsResponseCopyWithImpl<$Res, AffirmationsResponse>;
  @useResult
  $Res call({String affirmation});
}

/// @nodoc
class _$AffirmationsResponseCopyWithImpl<$Res,
        $Val extends AffirmationsResponse>
    implements $AffirmationsResponseCopyWith<$Res> {
  _$AffirmationsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AffirmationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? affirmation = null,
  }) {
    return _then(_value.copyWith(
      affirmation: null == affirmation
          ? _value.affirmation
          : affirmation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AffirmationsResponseImplCopyWith<$Res>
    implements $AffirmationsResponseCopyWith<$Res> {
  factory _$$AffirmationsResponseImplCopyWith(_$AffirmationsResponseImpl value,
          $Res Function(_$AffirmationsResponseImpl) then) =
      __$$AffirmationsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String affirmation});
}

/// @nodoc
class __$$AffirmationsResponseImplCopyWithImpl<$Res>
    extends _$AffirmationsResponseCopyWithImpl<$Res, _$AffirmationsResponseImpl>
    implements _$$AffirmationsResponseImplCopyWith<$Res> {
  __$$AffirmationsResponseImplCopyWithImpl(_$AffirmationsResponseImpl _value,
      $Res Function(_$AffirmationsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AffirmationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? affirmation = null,
  }) {
    return _then(_$AffirmationsResponseImpl(
      affirmation: null == affirmation
          ? _value.affirmation
          : affirmation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AffirmationsResponseImpl implements _AffirmationsResponse {
  _$AffirmationsResponseImpl({required this.affirmation});

  factory _$AffirmationsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AffirmationsResponseImplFromJson(json);

  @override
  final String affirmation;

  @override
  String toString() {
    return 'AffirmationsResponse(affirmation: $affirmation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AffirmationsResponseImpl &&
            (identical(other.affirmation, affirmation) ||
                other.affirmation == affirmation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, affirmation);

  /// Create a copy of AffirmationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AffirmationsResponseImplCopyWith<_$AffirmationsResponseImpl>
      get copyWith =>
          __$$AffirmationsResponseImplCopyWithImpl<_$AffirmationsResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AffirmationsResponseImplToJson(
      this,
    );
  }
}

abstract class _AffirmationsResponse implements AffirmationsResponse {
  factory _AffirmationsResponse({required final String affirmation}) =
      _$AffirmationsResponseImpl;

  factory _AffirmationsResponse.fromJson(Map<String, dynamic> json) =
      _$AffirmationsResponseImpl.fromJson;

  @override
  String get affirmation;

  /// Create a copy of AffirmationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AffirmationsResponseImplCopyWith<_$AffirmationsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
