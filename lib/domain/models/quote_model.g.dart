// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuoteModelImpl _$$QuoteModelImplFromJson(Map<String, dynamic> json) =>
    _$QuoteModelImpl(
      quote: json['QuoteModelUrl'] as String,
      author: json['QuoteModelAuthor'] as String?,
      fontWeightIndex: (json['fontWeightIndex'] as num?)?.toInt(),
      textAlignmentIndex: (json['textAlignmentIndex'] as num?)?.toInt(),
      mainAxisAlignmentIndex: (json['mainAxisAlignmentIndex'] as num?)?.toInt(),
      crossAxisAlignmentIndex:
          (json['crossAxisAlignmentIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuoteModelImplToJson(_$QuoteModelImpl instance) =>
    <String, dynamic>{
      'QuoteModelUrl': instance.quote,
      'QuoteModelAuthor': instance.author,
      'fontWeightIndex': instance.fontWeightIndex,
      'textAlignmentIndex': instance.textAlignmentIndex,
      'mainAxisAlignmentIndex': instance.mainAxisAlignmentIndex,
      'crossAxisAlignmentIndex': instance.crossAxisAlignmentIndex,
    };
