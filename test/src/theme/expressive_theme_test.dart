import 'package:expressive_kit/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveTheme', () {
    test('light theme builds with default parameters', () {
      final theme = ExpressiveTheme.light();
      expect(theme.brightness, Brightness.light);
      expect(theme.useMaterial3, isTrue);
      expect(theme.appBarTheme.centerTitle, isTrue);
      expect(theme.snackBarTheme.behavior, SnackBarBehavior.floating);
    });

    test('light theme builds with custom baseColor and fontFamily', () {
      final theme = ExpressiveTheme.light(
        baseColor: Colors.deepPurple,
        fontFamily: 'Roboto',
      );
      expect(theme.brightness, Brightness.light);
      expect(theme.textTheme.bodyMedium?.fontFamily, 'Roboto');
      expect(theme.snackBarTheme.contentTextStyle?.fontFamily, 'Roboto');
    });

    test('dark theme builds with default parameters', () {
      final theme = ExpressiveTheme.dark();
      expect(theme.brightness, Brightness.dark);
      expect(theme.useMaterial3, isTrue);
      expect(theme.appBarTheme.centerTitle, isTrue);
    });

    test('dark theme builds with custom baseColor and fontFamily', () {
      final theme = ExpressiveTheme.dark(
        baseColor: Colors.teal,
        fontFamily: 'Inter',
      );
      expect(theme.brightness, Brightness.dark);
      expect(theme.textTheme.bodyMedium?.fontFamily, 'Inter');
    });

    test('applyFontVariations extension applies variations correctly', () {
      const variations = <FontVariation>[
        FontVariation('wght', 700),
        FontVariation('ROND', 50),
      ];

      final textTheme = const TextTheme(
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(),
        headlineSmall: TextStyle(),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        labelLarge: TextStyle(),
        labelMedium: TextStyle(),
        labelSmall: TextStyle(),
      ).applyFontVariations(variations);

      expect(textTheme.displayLarge?.fontVariations, variations);
      expect(textTheme.displayMedium?.fontVariations, variations);
      expect(textTheme.displaySmall?.fontVariations, variations);
      expect(textTheme.headlineLarge?.fontVariations, variations);
      expect(textTheme.headlineMedium?.fontVariations, variations);
      expect(textTheme.headlineSmall?.fontVariations, variations);
      expect(textTheme.titleLarge?.fontVariations, variations);
      expect(textTheme.titleMedium?.fontVariations, variations);
      expect(textTheme.titleSmall?.fontVariations, variations);
      expect(textTheme.bodyLarge?.fontVariations, variations);
      expect(textTheme.bodyMedium?.fontVariations, variations);
      expect(textTheme.bodySmall?.fontVariations, variations);
      expect(textTheme.labelLarge?.fontVariations, variations);
      expect(textTheme.labelMedium?.fontVariations, variations);
      expect(textTheme.labelSmall?.fontVariations, variations);
    });

    test('applyFontVariations handles empty TextTheme gracefully', () {
      const variations = <FontVariation>[FontVariation('wght', 400)];
      const emptyTextTheme = TextTheme();
      final result = emptyTextTheme.applyFontVariations(variations);
      expect(result.bodyLarge, isNull);
    });
  });
}
