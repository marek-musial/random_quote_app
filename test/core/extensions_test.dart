import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_quote_app/core/extensions.dart';

void main() {
  late Color color;

  double brightnessFromRgb(int r, int g, int b) {
    return (r / 255) * 0.299 + (g / 255) * 0.587 + (b / 255) * 0.114;
  }

  group('Brightness', () {
    test('returns true if the color is bright', () {
      color = const Color.fromRGBO(255, 255, 255, 1);
      expect(color.isBright(), true);
    });

    test('returns false if the color is not bright', () {
      color = const Color.fromRGBO(0, 0, 0, 1);
      expect(color.isBright(), false);
    });

    test('grayscale values <= threshold are not bright', () {
      for (final v in [0, 16, 32, 64, 96, 110, 120, 126, 127]) {
        color = Color.fromRGBO(v, v, v, 1);
        expect(
          color.isBright(),
          false,
          reason: 'Expected not bright for grayscale value $v',
        );
      }
    });

    test('grayscale values > threshold are bright', () {
      for (final v in [128, 129, 140, 160, 192, 224, 255]) {
        color = Color.fromRGBO(v, v, v, 1);
        expect(
          color.isBright(),
          true,
          reason: 'Expected bright for grayscale value $v',
        );
      }
    });

    test('mixed RGB values follow weighted brightness formula', () {
      final cases = <({int r, int g, int b})>[
        (r: 255, g: 0, b: 0),
        (r: 0, g: 255, b: 0),
        (r: 0, g: 0, b: 255),
        (r: 200, g: 120, b: 20),
        (r: 40, g: 180, b: 220),
        (r: 127, g: 127, b: 127),
        (r: 128, g: 128, b: 128),
      ];

      for (final c in cases) {
        color = Color.fromRGBO(c.r, c.g, c.b, 1);
        final expected = brightnessFromRgb(c.r, c.g, c.b) > .5;
        expect(
          color.isBright(),
          expected,
          reason: 'r=${c.r}, g=${c.g}, b=${c.b}',
        );
      }
    });
  });

  group('Inversion', () {
    test('returns black if the color is very bright', () {
      const brightValues = [0.883, 0.9, 0.95, 1.0];
      const alphaValues = [0.0, 0.25, 0.5, 1.0];

      for (final r in brightValues) {
        for (final g in brightValues) {
          for (final b in brightValues) {
            for (final a in alphaValues) {
              color = Color.from(red: r, green: g, blue: b, alpha: a);
              expect(
                color.inverseColor(),
                Colors.black,
                reason: 'Expected black for r=$r, g=$g, b=$b, a=$a',
              );
            }
          }
        }
      }
    });

    test('returns white if the color is very dark', () {
      const darkValues = [0.0, 0.05, 0.1, 0.2, 0.234];
      const alphaValues = [0.0, 0.25, 0.5, 1.0];

      for (final r in darkValues) {
        for (final g in darkValues) {
          for (final b in darkValues) {
            for (final a in alphaValues) {
              color = Color.from(red: r, green: g, blue: b, alpha: a);
              expect(
                color.inverseColor(),
                Colors.white,
                reason: 'Expected white for r=$r, g=$g, b=$b, a=$a',
              );
            }
          }
        }
      }
    });

    test(
      'returns the inverse color with full opacity if the color is not very bright or dark',
      () {
        const channelValues = [0.0, 0.1, 0.234, 0.235, 0.5, 0.882, 0.883, 1.0];
        const alphaValues = [0.0, 0.25, 0.5, 1.0];

        for (final r in channelValues) {
          for (final g in channelValues) {
            for (final b in channelValues) {
              final isVeryBright = r > 0.882 && g > 0.882 && b > 0.882;
              final isVeryDark = r < 0.235 && g < 0.235 && b < 0.235;

              if (isVeryBright || isVeryDark) {
                continue;
              }

              for (final a in alphaValues) {
                color = Color.from(red: r, green: g, blue: b, alpha: a);
                final inverseColor = color.inverseColor();

                expect(inverseColor.r, closeTo(1 - color.r, 0.000001));
                expect(inverseColor.g, closeTo(1 - color.g, 0.000001));
                expect(inverseColor.b, closeTo(1 - color.b, 0.000001));
                expect(inverseColor.a, 1);
              }
            }
          }
        }
      },
    );
  });
}
