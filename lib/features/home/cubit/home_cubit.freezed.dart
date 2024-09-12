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
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Image? get rawImage => throw _privateConstructorUsedError;
  int? get fontWeightIndex => throw _privateConstructorUsedError;
  int? get textAlignmentIndex => throw _privateConstructorUsedError;
  int? get mainAxisAlignmentIndex => throw _privateConstructorUsedError;
  int? get crossAxisAlignmentIndex => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Color? get textColor => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Offset? get textPosition => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Size? get textSize => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? get scaleFactor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      QuoteModel? quoteModel,
      @JsonKey(includeFromJson: false, includeToJson: false) ui.Image? rawImage,
      int? fontWeightIndex,
      int? textAlignmentIndex,
      int? mainAxisAlignmentIndex,
      int? crossAxisAlignmentIndex,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ui.Color? textColor,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ui.Offset? textPosition,
      @JsonKey(includeFromJson: false, includeToJson: false) ui.Size? textSize,
      @JsonKey(includeFromJson: false, includeToJson: false)
      double? scaleFactor});

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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? imageModel = freezed,
    Object? quoteModel = freezed,
    Object? rawImage = freezed,
    Object? fontWeightIndex = freezed,
    Object? textAlignmentIndex = freezed,
    Object? mainAxisAlignmentIndex = freezed,
    Object? crossAxisAlignmentIndex = freezed,
    Object? textColor = freezed,
    Object? textPosition = freezed,
    Object? textSize = freezed,
    Object? scaleFactor = freezed,
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
      rawImage: freezed == rawImage
          ? _value.rawImage
          : rawImage // ignore: cast_nullable_to_non_nullable
              as ui.Image?,
      fontWeightIndex: freezed == fontWeightIndex
          ? _value.fontWeightIndex
          : fontWeightIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      textAlignmentIndex: freezed == textAlignmentIndex
          ? _value.textAlignmentIndex
          : textAlignmentIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      mainAxisAlignmentIndex: freezed == mainAxisAlignmentIndex
          ? _value.mainAxisAlignmentIndex
          : mainAxisAlignmentIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      crossAxisAlignmentIndex: freezed == crossAxisAlignmentIndex
          ? _value.crossAxisAlignmentIndex
          : crossAxisAlignmentIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      textColor: freezed == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as ui.Color?,
      textPosition: freezed == textPosition
          ? _value.textPosition
          : textPosition // ignore: cast_nullable_to_non_nullable
              as ui.Offset?,
      textSize: freezed == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as ui.Size?,
      scaleFactor: freezed == scaleFactor
          ? _value.scaleFactor
          : scaleFactor // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

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
      QuoteModel? quoteModel,
      @JsonKey(includeFromJson: false, includeToJson: false) ui.Image? rawImage,
      int? fontWeightIndex,
      int? textAlignmentIndex,
      int? mainAxisAlignmentIndex,
      int? crossAxisAlignmentIndex,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ui.Color? textColor,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ui.Offset? textPosition,
      @JsonKey(includeFromJson: false, includeToJson: false) ui.Size? textSize,
      @JsonKey(includeFromJson: false, includeToJson: false)
      double? scaleFactor});

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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? imageModel = freezed,
    Object? quoteModel = freezed,
    Object? rawImage = freezed,
    Object? fontWeightIndex = freezed,
    Object? textAlignmentIndex = freezed,
    Object? mainAxisAlignmentIndex = freezed,
    Object? crossAxisAlignmentIndex = freezed,
    Object? textColor = freezed,
    Object? textPosition = freezed,
    Object? textSize = freezed,
    Object? scaleFactor = freezed,
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
      rawImage: freezed == rawImage
          ? _value.rawImage
          : rawImage // ignore: cast_nullable_to_non_nullable
              as ui.Image?,
      fontWeightIndex: freezed == fontWeightIndex
          ? _value.fontWeightIndex
          : fontWeightIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      textAlignmentIndex: freezed == textAlignmentIndex
          ? _value.textAlignmentIndex
          : textAlignmentIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      mainAxisAlignmentIndex: freezed == mainAxisAlignmentIndex
          ? _value.mainAxisAlignmentIndex
          : mainAxisAlignmentIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      crossAxisAlignmentIndex: freezed == crossAxisAlignmentIndex
          ? _value.crossAxisAlignmentIndex
          : crossAxisAlignmentIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      textColor: freezed == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as ui.Color?,
      textPosition: freezed == textPosition
          ? _value.textPosition
          : textPosition // ignore: cast_nullable_to_non_nullable
              as ui.Offset?,
      textSize: freezed == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as ui.Size?,
      scaleFactor: freezed == scaleFactor
          ? _value.scaleFactor
          : scaleFactor // ignore: cast_nullable_to_non_nullable
              as double?,
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
      this.quoteModel,
      @JsonKey(includeFromJson: false, includeToJson: false) this.rawImage,
      this.fontWeightIndex,
      this.textAlignmentIndex,
      this.mainAxisAlignmentIndex,
      this.crossAxisAlignmentIndex,
      @JsonKey(includeFromJson: false, includeToJson: false) this.textColor,
      @JsonKey(includeFromJson: false, includeToJson: false) this.textPosition,
      @JsonKey(includeFromJson: false, includeToJson: false) this.textSize,
      @JsonKey(includeFromJson: false, includeToJson: false) this.scaleFactor})
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
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ui.Image? rawImage;
  @override
  final int? fontWeightIndex;
  @override
  final int? textAlignmentIndex;
  @override
  final int? mainAxisAlignmentIndex;
  @override
  final int? crossAxisAlignmentIndex;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ui.Color? textColor;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ui.Offset? textPosition;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ui.Size? textSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final double? scaleFactor;

  @override
  String toString() {
    return 'HomeState(status: $status, errorMessage: $errorMessage, imageModel: $imageModel, quoteModel: $quoteModel, rawImage: $rawImage, fontWeightIndex: $fontWeightIndex, textAlignmentIndex: $textAlignmentIndex, mainAxisAlignmentIndex: $mainAxisAlignmentIndex, crossAxisAlignmentIndex: $crossAxisAlignmentIndex, textColor: $textColor, textPosition: $textPosition, textSize: $textSize, scaleFactor: $scaleFactor)';
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
                other.quoteModel == quoteModel) &&
            (identical(other.rawImage, rawImage) ||
                other.rawImage == rawImage) &&
            (identical(other.fontWeightIndex, fontWeightIndex) ||
                other.fontWeightIndex == fontWeightIndex) &&
            (identical(other.textAlignmentIndex, textAlignmentIndex) ||
                other.textAlignmentIndex == textAlignmentIndex) &&
            (identical(other.mainAxisAlignmentIndex, mainAxisAlignmentIndex) ||
                other.mainAxisAlignmentIndex == mainAxisAlignmentIndex) &&
            (identical(
                    other.crossAxisAlignmentIndex, crossAxisAlignmentIndex) ||
                other.crossAxisAlignmentIndex == crossAxisAlignmentIndex) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.textPosition, textPosition) ||
                other.textPosition == textPosition) &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize) &&
            (identical(other.scaleFactor, scaleFactor) ||
                other.scaleFactor == scaleFactor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      errorMessage,
      imageModel,
      quoteModel,
      rawImage,
      fontWeightIndex,
      textAlignmentIndex,
      mainAxisAlignmentIndex,
      crossAxisAlignmentIndex,
      textColor,
      textPosition,
      textSize,
      scaleFactor);

  @JsonKey(ignore: true)
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
      final QuoteModel? quoteModel,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final ui.Image? rawImage,
      final int? fontWeightIndex,
      final int? textAlignmentIndex,
      final int? mainAxisAlignmentIndex,
      final int? crossAxisAlignmentIndex,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final ui.Color? textColor,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final ui.Offset? textPosition,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final ui.Size? textSize,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final double? scaleFactor}) = _$HomeStateImpl;
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
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Image? get rawImage;
  @override
  int? get fontWeightIndex;
  @override
  int? get textAlignmentIndex;
  @override
  int? get mainAxisAlignmentIndex;
  @override
  int? get crossAxisAlignmentIndex;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Color? get textColor;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Offset? get textPosition;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ui.Size? get textSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? get scaleFactor;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
