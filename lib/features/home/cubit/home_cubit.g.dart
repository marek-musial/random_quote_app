// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeStateImpl _$$HomeStateImplFromJson(Map<String, dynamic> json) =>
    _$HomeStateImpl(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ??
          Status.initial,
      imageModel: json['imageModel'] == null
          ? null
          : ImageModel.fromJson(json['imageModel'] as Map<String, dynamic>),
      quoteModel: json['quoteModel'] == null
          ? null
          : QuoteModel.fromJson(json['quoteModel'] as Map<String, dynamic>),
      compositionModel: json['compositionModel'] == null
          ? null
          : CompositionModel.fromJson(
              json['compositionModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HomeStateImplToJson(_$HomeStateImpl instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status]!,
      'imageModel': instance.imageModel,
      'quoteModel': instance.quoteModel,
      'compositionModel': instance.compositionModel,
    };

const _$StatusEnumMap = {
  Status.initial: 'initial',
  Status.loading: 'loading',
  Status.success: 'success',
  Status.error: 'error',
};
