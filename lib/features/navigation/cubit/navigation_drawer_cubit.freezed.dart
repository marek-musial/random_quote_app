// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_drawer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NavigationDrawerState {
  int get navigationIndex => throw _privateConstructorUsedError;

  /// Create a copy of NavigationDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NavigationDrawerStateCopyWith<NavigationDrawerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationDrawerStateCopyWith<$Res> {
  factory $NavigationDrawerStateCopyWith(NavigationDrawerState value,
          $Res Function(NavigationDrawerState) then) =
      _$NavigationDrawerStateCopyWithImpl<$Res, NavigationDrawerState>;
  @useResult
  $Res call({int navigationIndex});
}

/// @nodoc
class _$NavigationDrawerStateCopyWithImpl<$Res,
        $Val extends NavigationDrawerState>
    implements $NavigationDrawerStateCopyWith<$Res> {
  _$NavigationDrawerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NavigationDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? navigationIndex = null,
  }) {
    return _then(_value.copyWith(
      navigationIndex: null == navigationIndex
          ? _value.navigationIndex
          : navigationIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NavigationDrawerStateImplCopyWith<$Res>
    implements $NavigationDrawerStateCopyWith<$Res> {
  factory _$$NavigationDrawerStateImplCopyWith(
          _$NavigationDrawerStateImpl value,
          $Res Function(_$NavigationDrawerStateImpl) then) =
      __$$NavigationDrawerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int navigationIndex});
}

/// @nodoc
class __$$NavigationDrawerStateImplCopyWithImpl<$Res>
    extends _$NavigationDrawerStateCopyWithImpl<$Res,
        _$NavigationDrawerStateImpl>
    implements _$$NavigationDrawerStateImplCopyWith<$Res> {
  __$$NavigationDrawerStateImplCopyWithImpl(_$NavigationDrawerStateImpl _value,
      $Res Function(_$NavigationDrawerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NavigationDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? navigationIndex = null,
  }) {
    return _then(_$NavigationDrawerStateImpl(
      navigationIndex: null == navigationIndex
          ? _value.navigationIndex
          : navigationIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$NavigationDrawerStateImpl implements _NavigationDrawerState {
  const _$NavigationDrawerStateImpl({this.navigationIndex = 0});

  @override
  @JsonKey()
  final int navigationIndex;

  @override
  String toString() {
    return 'NavigationDrawerState(navigationIndex: $navigationIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigationDrawerStateImpl &&
            (identical(other.navigationIndex, navigationIndex) ||
                other.navigationIndex == navigationIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, navigationIndex);

  /// Create a copy of NavigationDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigationDrawerStateImplCopyWith<_$NavigationDrawerStateImpl>
      get copyWith => __$$NavigationDrawerStateImplCopyWithImpl<
          _$NavigationDrawerStateImpl>(this, _$identity);
}

abstract class _NavigationDrawerState implements NavigationDrawerState {
  const factory _NavigationDrawerState({final int navigationIndex}) =
      _$NavigationDrawerStateImpl;

  @override
  int get navigationIndex;

  /// Create a copy of NavigationDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NavigationDrawerStateImplCopyWith<_$NavigationDrawerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
