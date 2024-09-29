import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@unfreezed
class QuoteModel with _$QuoteModel {
  factory QuoteModel({
    @JsonKey(name: 'QuoteModelUrl') required String quote,
    @JsonKey(name: 'QuoteModelAuthor') String? author,
    int? fontWeightIndex,
    int? textAlignmentIndex,
    int? mainAxisAlignmentIndex,
    int? crossAxisAlignmentIndex,
    @JsonKey(includeFromJson: false, includeToJson: false) Color? textColor,
    @JsonKey(includeFromJson: false, includeToJson: false) Offset? textPosition,
    @JsonKey(includeFromJson: false, includeToJson: false) Size? textSize,
  }) = _QuoteModel;

  factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);
}
