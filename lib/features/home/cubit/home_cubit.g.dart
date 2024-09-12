// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeStateImpl _$$HomeStateImplFromJson(Map<String, dynamic> json) =>
    _$HomeStateImpl(
      imageModel: json['imageModel'] == null
          ? null
          : ImageModel.fromJson(json['imageModel'] as Map<String, dynamic>),
      quoteModel: json['quoteModel'] == null
          ? null
          : QuoteModel.fromJson(json['quoteModel'] as Map<String, dynamic>),
      fontWeightIndex: (json['fontWeightIndex'] as num?)?.toInt(),
      textAlignmentIndex: (json['textAlignmentIndex'] as num?)?.toInt(),
      mainAxisAlignmentIndex: (json['mainAxisAlignmentIndex'] as num?)?.toInt(),
      crossAxisAlignmentIndex:
          (json['crossAxisAlignmentIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$HomeStateImplToJson(_$HomeStateImpl instance) =>
    <String, dynamic>{
      'imageModel': instance.imageModel,
      'quoteModel': instance.quoteModel,
      'fontWeightIndex': instance.fontWeightIndex,
      'textAlignmentIndex': instance.textAlignmentIndex,
      'mainAxisAlignmentIndex': instance.mainAxisAlignmentIndex,
      'crossAxisAlignmentIndex': instance.crossAxisAlignmentIndex,
    };
