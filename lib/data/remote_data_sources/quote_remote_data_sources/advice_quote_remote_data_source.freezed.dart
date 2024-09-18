// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advice_quote_remote_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdviceResponse _$AdviceResponseFromJson(Map<String, dynamic> json) {
  return _AdviceResponse.fromJson(json);
}

/// @nodoc
mixin _$AdviceResponse {
  AdviceSlip get slip => throw _privateConstructorUsedError;

  /// Serializes this AdviceResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdviceResponseCopyWith<AdviceResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdviceResponseCopyWith<$Res> {
  factory $AdviceResponseCopyWith(
          AdviceResponse value, $Res Function(AdviceResponse) then) =
      _$AdviceResponseCopyWithImpl<$Res, AdviceResponse>;
  @useResult
  $Res call({AdviceSlip slip});

  $AdviceSlipCopyWith<$Res> get slip;
}

/// @nodoc
class _$AdviceResponseCopyWithImpl<$Res, $Val extends AdviceResponse>
    implements $AdviceResponseCopyWith<$Res> {
  _$AdviceResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slip = null,
  }) {
    return _then(_value.copyWith(
      slip: null == slip
          ? _value.slip
          : slip // ignore: cast_nullable_to_non_nullable
              as AdviceSlip,
    ) as $Val);
  }

  /// Create a copy of AdviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdviceSlipCopyWith<$Res> get slip {
    return $AdviceSlipCopyWith<$Res>(_value.slip, (value) {
      return _then(_value.copyWith(slip: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdviceResponseImplCopyWith<$Res>
    implements $AdviceResponseCopyWith<$Res> {
  factory _$$AdviceResponseImplCopyWith(_$AdviceResponseImpl value,
          $Res Function(_$AdviceResponseImpl) then) =
      __$$AdviceResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AdviceSlip slip});

  @override
  $AdviceSlipCopyWith<$Res> get slip;
}

/// @nodoc
class __$$AdviceResponseImplCopyWithImpl<$Res>
    extends _$AdviceResponseCopyWithImpl<$Res, _$AdviceResponseImpl>
    implements _$$AdviceResponseImplCopyWith<$Res> {
  __$$AdviceResponseImplCopyWithImpl(
      _$AdviceResponseImpl _value, $Res Function(_$AdviceResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slip = null,
  }) {
    return _then(_$AdviceResponseImpl(
      slip: null == slip
          ? _value.slip
          : slip // ignore: cast_nullable_to_non_nullable
              as AdviceSlip,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdviceResponseImpl implements _AdviceResponse {
  _$AdviceResponseImpl({required this.slip});

  factory _$AdviceResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdviceResponseImplFromJson(json);

  @override
  final AdviceSlip slip;

  @override
  String toString() {
    return 'AdviceResponse(slip: $slip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdviceResponseImpl &&
            (identical(other.slip, slip) || other.slip == slip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slip);

  /// Create a copy of AdviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdviceResponseImplCopyWith<_$AdviceResponseImpl> get copyWith =>
      __$$AdviceResponseImplCopyWithImpl<_$AdviceResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdviceResponseImplToJson(
      this,
    );
  }
}

abstract class _AdviceResponse implements AdviceResponse {
  factory _AdviceResponse({required final AdviceSlip slip}) =
      _$AdviceResponseImpl;

  factory _AdviceResponse.fromJson(Map<String, dynamic> json) =
      _$AdviceResponseImpl.fromJson;

  @override
  AdviceSlip get slip;

  /// Create a copy of AdviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdviceResponseImplCopyWith<_$AdviceResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdviceSlip _$AdviceSlipFromJson(Map<String, dynamic> json) {
  return _AdviceSlip.fromJson(json);
}

/// @nodoc
mixin _$AdviceSlip {
  String get advice => throw _privateConstructorUsedError;

  /// Serializes this AdviceSlip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdviceSlip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdviceSlipCopyWith<AdviceSlip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdviceSlipCopyWith<$Res> {
  factory $AdviceSlipCopyWith(
          AdviceSlip value, $Res Function(AdviceSlip) then) =
      _$AdviceSlipCopyWithImpl<$Res, AdviceSlip>;
  @useResult
  $Res call({String advice});
}

/// @nodoc
class _$AdviceSlipCopyWithImpl<$Res, $Val extends AdviceSlip>
    implements $AdviceSlipCopyWith<$Res> {
  _$AdviceSlipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdviceSlip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? advice = null,
  }) {
    return _then(_value.copyWith(
      advice: null == advice
          ? _value.advice
          : advice // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdviceSlipImplCopyWith<$Res>
    implements $AdviceSlipCopyWith<$Res> {
  factory _$$AdviceSlipImplCopyWith(
          _$AdviceSlipImpl value, $Res Function(_$AdviceSlipImpl) then) =
      __$$AdviceSlipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String advice});
}

/// @nodoc
class __$$AdviceSlipImplCopyWithImpl<$Res>
    extends _$AdviceSlipCopyWithImpl<$Res, _$AdviceSlipImpl>
    implements _$$AdviceSlipImplCopyWith<$Res> {
  __$$AdviceSlipImplCopyWithImpl(
      _$AdviceSlipImpl _value, $Res Function(_$AdviceSlipImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdviceSlip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? advice = null,
  }) {
    return _then(_$AdviceSlipImpl(
      advice: null == advice
          ? _value.advice
          : advice // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdviceSlipImpl implements _AdviceSlip {
  _$AdviceSlipImpl({required this.advice});

  factory _$AdviceSlipImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdviceSlipImplFromJson(json);

  @override
  final String advice;

  @override
  String toString() {
    return 'AdviceSlip(advice: $advice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdviceSlipImpl &&
            (identical(other.advice, advice) || other.advice == advice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, advice);

  /// Create a copy of AdviceSlip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdviceSlipImplCopyWith<_$AdviceSlipImpl> get copyWith =>
      __$$AdviceSlipImplCopyWithImpl<_$AdviceSlipImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdviceSlipImplToJson(
      this,
    );
  }
}

abstract class _AdviceSlip implements AdviceSlip {
  factory _AdviceSlip({required final String advice}) = _$AdviceSlipImpl;

  factory _AdviceSlip.fromJson(Map<String, dynamic> json) =
      _$AdviceSlipImpl.fromJson;

  @override
  String get advice;

  /// Create a copy of AdviceSlip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdviceSlipImplCopyWith<_$AdviceSlipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
