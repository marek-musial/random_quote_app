import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@unfreezed
class QuoteModel with _$QuoteModel {
  factory QuoteModel({
    @JsonKey(name: 'QuoteModelUrl') required String quote,
    @JsonKey(name: 'QuoteModelAuthor') String? author,
  }) = _QuoteModel;

  factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);
}
