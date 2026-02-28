// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompositionModelImpl _$$CompositionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CompositionModelImpl(
      fontWeightIndex: (json['fontWeightIndex'] as num?)?.toInt() ?? 4,
      textAlignmentIndex: (json['textAlignmentIndex'] as num?)?.toInt() ?? 2,
      mainAxisAlignmentIndex:
          (json['mainAxisAlignmentIndex'] as num?)?.toInt() ?? 2,
      crossAxisAlignmentIndex:
          (json['crossAxisAlignmentIndex'] as num?)?.toInt() ?? 2,
      fontSize: (json['fontSize'] as num?)?.toInt() ?? 8,
      authorFontSize: (json['authorFontSize'] as num?)?.toInt() ?? 6,
      textColor: _colorFromJson((json['textColor'] as num?)?.toInt()),
    );

Map<String, dynamic> _$$CompositionModelImplToJson(
        _$CompositionModelImpl instance) =>
    <String, dynamic>{
      'fontWeightIndex': instance.fontWeightIndex,
      'textAlignmentIndex': instance.textAlignmentIndex,
      'mainAxisAlignmentIndex': instance.mainAxisAlignmentIndex,
      'crossAxisAlignmentIndex': instance.crossAxisAlignmentIndex,
      'fontSize': instance.fontSize,
      'authorFontSize': instance.authorFontSize,
      'textColor': _colorToJson(instance.textColor),
    };
