// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeState _$HomeStateFromJson(Map<String, dynamic> json) {
  return _HomeState.fromJson(json);
}

/// @nodoc
mixin _$HomeState {
  @JsonKey(includeFromJson: false)
  Status get status => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get errorMessage => throw _privateConstructorUsedError;
  ImageModel? get imageModel => throw _privateConstructorUsedError;
  QuoteModel? get quoteModel => throw _privateConstructorUsedError;

  /// Serializes this HomeState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false) Status status,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? errorMessage,
      ImageModel? imageModel,
      QuoteModel? quoteModel});

  $ImageModelCopyWith<$Res>? get imageModel;
  $QuoteModelCopyWith<$Res>? get quoteModel;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? imageModel = freezed,
    Object? quoteModel = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      imageModel: freezed == imageModel
          ? _value.imageModel
          : imageModel // ignore: cast_nullable_to_non_nullable
              as ImageModel?,
      quoteModel: freezed == quoteModel
          ? _value.quoteModel
          : quoteModel // ignore: cast_nullable_to_non_nullable
              as QuoteModel?,
    ) as $Val);
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageModelCopyWith<$Res>? get imageModel {
    if (_value.imageModel == null) {
      return null;
    }

    return $ImageModelCopyWith<$Res>(_value.imageModel!, (value) {
      return _then(_value.copyWith(imageModel: value) as $Val);
    });
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteModelCopyWith<$Res>? get quoteModel {
    if (_value.quoteModel == null) {
      return null;
    }

    return $QuoteModelCopyWith<$Res>(_value.quoteModel!, (value) {
      return _then(_value.copyWith(quoteModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false) Status status,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? errorMessage,
      ImageModel? imageModel,
      QuoteModel? quoteModel});

  @override
  $ImageModelCopyWith<$Res>? get imageModel;
  @override
  $QuoteModelCopyWith<$Res>? get quoteModel;
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? imageModel = freezed,
    Object? quoteModel = freezed,
  }) {
    return _then(_$HomeStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      imageModel: freezed == imageModel
          ? _value.imageModel
          : imageModel // ignore: cast_nullable_to_non_nullable
              as ImageModel?,
      quoteModel: freezed == quoteModel
          ? _value.quoteModel
          : quoteModel // ignore: cast_nullable_to_non_nullable
              as QuoteModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeStateImpl extends _HomeState {
  const _$HomeStateImpl(
      {@JsonKey(includeFromJson: false) this.status = Status.initial,
      @JsonKey(includeFromJson: false, includeToJson: false) this.errorMessage,
      this.imageModel,
      this.quoteModel})
      : super._();

  factory _$HomeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeStateImplFromJson(json);

  @override
  @JsonKey(includeFromJson: false)
  final Status status;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? errorMessage;
  @override
  final ImageModel? imageModel;
  @override
  final QuoteModel? quoteModel;

  @override
  String toString() {
    return 'HomeState(status: $status, errorMessage: $errorMessage, imageModel: $imageModel, quoteModel: $quoteModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.imageModel, imageModel) ||
                other.imageModel == imageModel) &&
            (identical(other.quoteModel, quoteModel) ||
                other.quoteModel == quoteModel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, errorMessage, imageModel, quoteModel);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeStateImplToJson(
      this,
    );
  }
}

abstract class _HomeState extends HomeState {
  const factory _HomeState(
      {@JsonKey(includeFromJson: false) final Status status,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? errorMessage,
      final ImageModel? imageModel,
      final QuoteModel? quoteModel}) = _$HomeStateImpl;
  const _HomeState._() : super._();

  factory _HomeState.fromJson(Map<String, dynamic> json) =
      _$HomeStateImpl.fromJson;

  @override
  @JsonKey(includeFromJson: false)
  Status get status;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get errorMessage;
  @override
  ImageModel? get imageModel;
  @override
  QuoteModel? get quoteModel;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
