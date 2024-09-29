// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuoteModel _$QuoteModelFromJson(Map<String, dynamic> json) {
  return _QuoteModel.fromJson(json);
}

/// @nodoc
mixin _$QuoteModel {
  @JsonKey(name: 'QuoteModelUrl')
  String get quote => throw _privateConstructorUsedError;
  @JsonKey(name: 'QuoteModelUrl')
  set quote(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'QuoteModelAuthor')
  String? get author => throw _privateConstructorUsedError;
  @JsonKey(name: 'QuoteModelAuthor')
  set author(String? value) => throw _privateConstructorUsedError;
  int? get fontWeightIndex => throw _privateConstructorUsedError;
  set fontWeightIndex(int? value) => throw _privateConstructorUsedError;
  int? get textAlignmentIndex => throw _privateConstructorUsedError;
  set textAlignmentIndex(int? value) => throw _privateConstructorUsedError;
  int? get mainAxisAlignmentIndex => throw _privateConstructorUsedError;
  set mainAxisAlignmentIndex(int? value) => throw _privateConstructorUsedError;
  int? get crossAxisAlignmentIndex => throw _privateConstructorUsedError;
  set crossAxisAlignmentIndex(int? value) => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get textColor => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set textColor(Color? value) => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Offset? get textPosition => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set textPosition(Offset? value) => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Size? get textSize => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set textSize(Size? value) => throw _privateConstructorUsedError;

  /// Serializes this QuoteModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteModelCopyWith<QuoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteModelCopyWith<$Res> {
  factory $QuoteModelCopyWith(
          QuoteModel value, $Res Function(QuoteModel) then) =
      _$QuoteModelCopyWithImpl<$Res, QuoteModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'QuoteModelUrl') String quote,
      @JsonKey(name: 'QuoteModelAuthor') String? author,
      int? fontWeightIndex,
      int? textAlignmentIndex,
      int? mainAxisAlignmentIndex,
      int? crossAxisAlignmentIndex,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? textColor,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Offset? textPosition,
      @JsonKey(includeFromJson: false, includeToJson: false) Size? textSize});
}

/// @nodoc
class _$QuoteModelCopyWithImpl<$Res, $Val extends QuoteModel>
    implements $QuoteModelCopyWith<$Res> {
  _$QuoteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quote = null,
    Object? author = freezed,
    Object? fontWeightIndex = freezed,
    Object? textAlignmentIndex = freezed,
    Object? mainAxisAlignmentIndex = freezed,
    Object? crossAxisAlignmentIndex = freezed,
    Object? textColor = freezed,
    Object? textPosition = freezed,
    Object? textSize = freezed,
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
              as Color?,
      textPosition: freezed == textPosition
          ? _value.textPosition
          : textPosition // ignore: cast_nullable_to_non_nullable
              as Offset?,
      textSize: freezed == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as Size?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuoteModelImplCopyWith<$Res>
    implements $QuoteModelCopyWith<$Res> {
  factory _$$QuoteModelImplCopyWith(
          _$QuoteModelImpl value, $Res Function(_$QuoteModelImpl) then) =
      __$$QuoteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'QuoteModelUrl') String quote,
      @JsonKey(name: 'QuoteModelAuthor') String? author,
      int? fontWeightIndex,
      int? textAlignmentIndex,
      int? mainAxisAlignmentIndex,
      int? crossAxisAlignmentIndex,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? textColor,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Offset? textPosition,
      @JsonKey(includeFromJson: false, includeToJson: false) Size? textSize});
}

/// @nodoc
class __$$QuoteModelImplCopyWithImpl<$Res>
    extends _$QuoteModelCopyWithImpl<$Res, _$QuoteModelImpl>
    implements _$$QuoteModelImplCopyWith<$Res> {
  __$$QuoteModelImplCopyWithImpl(
      _$QuoteModelImpl _value, $Res Function(_$QuoteModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuoteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quote = null,
    Object? author = freezed,
    Object? fontWeightIndex = freezed,
    Object? textAlignmentIndex = freezed,
    Object? mainAxisAlignmentIndex = freezed,
    Object? crossAxisAlignmentIndex = freezed,
    Object? textColor = freezed,
    Object? textPosition = freezed,
    Object? textSize = freezed,
  }) {
    return _then(_$QuoteModelImpl(
      quote: null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as Color?,
      textPosition: freezed == textPosition
          ? _value.textPosition
          : textPosition // ignore: cast_nullable_to_non_nullable
              as Offset?,
      textSize: freezed == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as Size?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteModelImpl implements _QuoteModel {
  _$QuoteModelImpl(
      {@JsonKey(name: 'QuoteModelUrl') required this.quote,
      @JsonKey(name: 'QuoteModelAuthor') this.author,
      this.fontWeightIndex,
      this.textAlignmentIndex,
      this.mainAxisAlignmentIndex,
      this.crossAxisAlignmentIndex,
      @JsonKey(includeFromJson: false, includeToJson: false) this.textColor,
      @JsonKey(includeFromJson: false, includeToJson: false) this.textPosition,
      @JsonKey(includeFromJson: false, includeToJson: false) this.textSize});

  factory _$QuoteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteModelImplFromJson(json);

  @override
  @JsonKey(name: 'QuoteModelUrl')
  String quote;
  @override
  @JsonKey(name: 'QuoteModelAuthor')
  String? author;
  @override
  int? fontWeightIndex;
  @override
  int? textAlignmentIndex;
  @override
  int? mainAxisAlignmentIndex;
  @override
  int? crossAxisAlignmentIndex;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? textColor;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Offset? textPosition;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Size? textSize;

  @override
  String toString() {
    return 'QuoteModel(quote: $quote, author: $author, fontWeightIndex: $fontWeightIndex, textAlignmentIndex: $textAlignmentIndex, mainAxisAlignmentIndex: $mainAxisAlignmentIndex, crossAxisAlignmentIndex: $crossAxisAlignmentIndex, textColor: $textColor, textPosition: $textPosition, textSize: $textSize)';
  }

  /// Create a copy of QuoteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteModelImplCopyWith<_$QuoteModelImpl> get copyWith =>
      __$$QuoteModelImplCopyWithImpl<_$QuoteModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteModelImplToJson(
      this,
    );
  }
}

abstract class _QuoteModel implements QuoteModel {
  factory _QuoteModel(
      {@JsonKey(name: 'QuoteModelUrl') required String quote,
      @JsonKey(name: 'QuoteModelAuthor') String? author,
      int? fontWeightIndex,
      int? textAlignmentIndex,
      int? mainAxisAlignmentIndex,
      int? crossAxisAlignmentIndex,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? textColor,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Offset? textPosition,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Size? textSize}) = _$QuoteModelImpl;

  factory _QuoteModel.fromJson(Map<String, dynamic> json) =
      _$QuoteModelImpl.fromJson;

  @override
  @JsonKey(name: 'QuoteModelUrl')
  String get quote;
  @JsonKey(name: 'QuoteModelUrl')
  set quote(String value);
  @override
  @JsonKey(name: 'QuoteModelAuthor')
  String? get author;
  @JsonKey(name: 'QuoteModelAuthor')
  set author(String? value);
  @override
  int? get fontWeightIndex;
  set fontWeightIndex(int? value);
  @override
  int? get textAlignmentIndex;
  set textAlignmentIndex(int? value);
  @override
  int? get mainAxisAlignmentIndex;
  set mainAxisAlignmentIndex(int? value);
  @override
  int? get crossAxisAlignmentIndex;
  set crossAxisAlignmentIndex(int? value);
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get textColor;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set textColor(Color? value);
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Offset? get textPosition;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set textPosition(Offset? value);
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Size? get textSize;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set textSize(Size? value);

  /// Create a copy of QuoteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteModelImplCopyWith<_$QuoteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
