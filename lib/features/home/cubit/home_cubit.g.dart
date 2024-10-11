// coverage:ignore-file
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
    );

Map<String, dynamic> _$$HomeStateImplToJson(_$HomeStateImpl instance) =>
    <String, dynamic>{
      'imageModel': instance.imageModel,
      'quoteModel': instance.quoteModel,
    };
