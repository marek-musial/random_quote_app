// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'root_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RootState _$RootStateFromJson(Map<String, dynamic> json) {
  return _RootState.fromJson(json);
}

/// @nodoc
mixin _$RootState {
  int? get themeColorValue => throw _privateConstructorUsedError;
  bool get isThemeBright => throw _privateConstructorUsedError;

  /// Serializes this RootState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RootState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RootStateCopyWith<RootState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RootStateCopyWith<$Res> {
  factory $RootStateCopyWith(RootState value, $Res Function(RootState) then) =
      _$RootStateCopyWithImpl<$Res, RootState>;
  @useResult
  $Res call({int? themeColorValue, bool isThemeBright});
}

/// @nodoc
class _$RootStateCopyWithImpl<$Res, $Val extends RootState>
    implements $RootStateCopyWith<$Res> {
  _$RootStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RootState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeColorValue = freezed,
    Object? isThemeBright = null,
  }) {
    return _then(_value.copyWith(
      themeColorValue: freezed == themeColorValue
          ? _value.themeColorValue
          : themeColorValue // ignore: cast_nullable_to_non_nullable
              as int?,
      isThemeBright: null == isThemeBright
          ? _value.isThemeBright
          : isThemeBright // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RootStateImplCopyWith<$Res>
    implements $RootStateCopyWith<$Res> {
  factory _$$RootStateImplCopyWith(
          _$RootStateImpl value, $Res Function(_$RootStateImpl) then) =
      __$$RootStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? themeColorValue, bool isThemeBright});
}

/// @nodoc
class __$$RootStateImplCopyWithImpl<$Res>
    extends _$RootStateCopyWithImpl<$Res, _$RootStateImpl>
    implements _$$RootStateImplCopyWith<$Res> {
  __$$RootStateImplCopyWithImpl(
      _$RootStateImpl _value, $Res Function(_$RootStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RootState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeColorValue = freezed,
    Object? isThemeBright = null,
  }) {
    return _then(_$RootStateImpl(
      themeColorValue: freezed == themeColorValue
          ? _value.themeColorValue
          : themeColorValue // ignore: cast_nullable_to_non_nullable
              as int?,
      isThemeBright: null == isThemeBright
          ? _value.isThemeBright
          : isThemeBright // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RootStateImpl implements _RootState {
  const _$RootStateImpl({this.themeColorValue, this.isThemeBright = true});

  factory _$RootStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$RootStateImplFromJson(json);

  @override
  final int? themeColorValue;
  @override
  @JsonKey()
  final bool isThemeBright;

  @override
  String toString() {
    return 'RootState(themeColorValue: $themeColorValue, isThemeBright: $isThemeBright)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RootStateImpl &&
            (identical(other.themeColorValue, themeColorValue) ||
                other.themeColorValue == themeColorValue) &&
            (identical(other.isThemeBright, isThemeBright) ||
                other.isThemeBright == isThemeBright));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeColorValue, isThemeBright);

  /// Create a copy of RootState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RootStateImplCopyWith<_$RootStateImpl> get copyWith =>
      __$$RootStateImplCopyWithImpl<_$RootStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RootStateImplToJson(
      this,
    );
  }
}

abstract class _RootState implements RootState {
  const factory _RootState(
      {final int? themeColorValue, final bool isThemeBright}) = _$RootStateImpl;

  factory _RootState.fromJson(Map<String, dynamic> json) =
      _$RootStateImpl.fromJson;

  @override
  int? get themeColorValue;
  @override
  bool get isThemeBright;

  /// Create a copy of RootState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RootStateImplCopyWith<_$RootStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
