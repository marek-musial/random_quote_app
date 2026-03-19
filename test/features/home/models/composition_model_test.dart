import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:random_quote_app/features/home/models/composition_model.dart';

void main() {
  group('CompositionModel', () {
    test('uses null values on creation with no arguments', () {
      final model = CompositionModel();

      expect(model.fontWeightIndex, isNull);
      expect(model.textAlignmentIndex, isNull);
      expect(model.mainAxisAlignmentIndex, isNull);
      expect(model.crossAxisAlignmentIndex, isNull);
      expect(model.fontSize, isNull);
      expect(model.authorFontSize, isNull);
      expect(model.textColor, isNull);
      expect(model.rawImage, isNull);
    });

    group('fromJson', () {
      test('applies defaults for missing values', () {
        final model = CompositionModel.fromJson(<String, dynamic>{});

        expect(model.fontWeightIndex, 4);
        expect(model.textAlignmentIndex, 2);
        expect(model.mainAxisAlignmentIndex, 2);
        expect(model.crossAxisAlignmentIndex, 2);
        expect(model.fontSize, 8);
        expect(model.authorFontSize, 6);
        expect(model.textColor, isNull);
        expect(model.rawImage, isNull);
      });

      test('converts textColor int to Color', () {
        final model = CompositionModel.fromJson(
          <String, dynamic>{
            'textColor': Colors.orange.toARGB32(),
          },
        );

        expect(model.textColor?.toARGB32(), Colors.orange.toARGB32());
      });
    });

    group('toJson', () {
      test('toJson converts textColor to int and omits rawImage', () {
        final model = CompositionModel(
          fontWeightIndex: 5,
          textAlignmentIndex: 1,
          mainAxisAlignmentIndex: 0,
          crossAxisAlignmentIndex: 3,
          fontSize: 10,
          authorFontSize: 7,
          textColor: Colors.blue,
        );

        final json = model.toJson();

        expect(json['fontWeightIndex'], 5);
        expect(json['textAlignmentIndex'], 1);
        expect(json['mainAxisAlignmentIndex'], 0);
        expect(json['crossAxisAlignmentIndex'], 3);
        expect(json['fontSize'], 10);
        expect(json['authorFontSize'], 7);
        expect(json['textColor'], Colors.blue.toARGB32());
        expect(json.containsKey('rawImage'), isFalse);
      });
    });
  });
}
