import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'composition_model.freezed.dart';
part 'composition_model.g.dart';

@unfreezed
class CompositionModel with _$CompositionModel {
  factory CompositionModel({
    @JsonKey(defaultValue: 4) int? fontWeightIndex,
    @JsonKey(defaultValue: 2) int? textAlignmentIndex,
    @JsonKey(defaultValue: 2) int? mainAxisAlignmentIndex,
    @JsonKey(defaultValue: 2) int? crossAxisAlignmentIndex,
    @JsonKey(defaultValue: 8) int? fontSize,
    @JsonKey(defaultValue: 6) int? authorFontSize,
    @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson) Color? textColor,
    @JsonKey(includeFromJson: false, includeToJson: false) ui.Image? rawImage,
  }) = _CompositionModel;

  factory CompositionModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CompositionModelFromJson(json);
}

Color? _colorFromJson(int? colorValue) => colorValue != null //R
    ? Color(colorValue)
    : null;

int? _colorToJson(Color? color) => color?.toARGB32();
