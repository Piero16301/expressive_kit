import 'package:expressive_kit/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveTheme', () {
    test('defaultTheme and defaultThemeMode are ThemeMode.system', () {
      expect(ExpressiveTheme.defaultTheme, ThemeMode.system);
    });

    test('light theme builds with default parameters', () {
      final theme = ExpressiveTheme.light();
      final expectedScheme = ColorScheme.fromSeed(
        seedColor: ExpressiveColors.defaultColor,
      );
      expect(theme.brightness, Brightness.light);
      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.primary, expectedScheme.primary);
      expect(
        theme.textTheme.bodyMedium?.fontFamily,
        ExpressiveFonts.defaultFont,
      );
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
      final expectedScheme = ColorScheme.fromSeed(
        seedColor: ExpressiveColors.defaultColor,
        brightness: Brightness.dark,
      );
      expect(theme.brightness, Brightness.dark);
      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.primary, expectedScheme.primary);
      expect(
        theme.textTheme.bodyMedium?.fontFamily,
        ExpressiveFonts.defaultFont,
      );
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

    test('toKey and getThemeName return standardized keys for ThemeMode', () {
      expect(ExpressiveTheme.toKey(ThemeMode.light), ExpressiveTheme.lightKey);
      expect(ExpressiveTheme.toKey(ThemeMode.dark), ExpressiveTheme.darkKey);
      expect(
        ExpressiveTheme.toKey(ThemeMode.system),
        ExpressiveTheme.systemKey,
      );

      expect(ExpressiveTheme.getThemeName(ThemeMode.light), 'LIGHT');
      expect(ExpressiveTheme.getThemeName(ThemeMode.dark), 'DARK');
      expect(ExpressiveTheme.getThemeName(ThemeMode.system), 'SYSTEM');
    });

    test('fromKey and getThemeByName deserialize strings correctly', () {
      expect(ExpressiveTheme.fromKey('LIGHT'), ThemeMode.light);
      expect(ExpressiveTheme.fromKey('light'), ThemeMode.light);
      expect(ExpressiveTheme.fromKey('DARK'), ThemeMode.dark);
      expect(ExpressiveTheme.fromKey('Dark'), ThemeMode.dark);
      expect(ExpressiveTheme.fromKey('SYSTEM'), ThemeMode.system);
      expect(ExpressiveTheme.fromKey('system'), ThemeMode.system);

      // Null and unrecognized keys fallback to defaultTheme (ThemeMode.system)
      expect(ExpressiveTheme.fromKey(null), ExpressiveTheme.defaultTheme);
      expect(ExpressiveTheme.fromKey('UNKNOWN'), ExpressiveTheme.defaultTheme);

      // Custom fallback parameter
      expect(
        ExpressiveTheme.fromKey('INVALID', fallback: ThemeMode.light),
        ThemeMode.light,
      );
      expect(
        ExpressiveTheme.fromKey(null, fallback: ThemeMode.dark),
        ThemeMode.dark,
      );

      // getThemeByName alias
      expect(ExpressiveTheme.getThemeByName('LIGHT'), ThemeMode.light);
      expect(
        ExpressiveTheme.getThemeByName('invalid', fallback: ThemeMode.light),
        ThemeMode.light,
      );
    });
  });

  group('ThemeHelper', () {
    test('constants match ExpressiveTheme keys', () {
      expect(ThemeHelper.lightKey, 'LIGHT');
      expect(ThemeHelper.darkKey, 'DARK');
      expect(ThemeHelper.systemKey, 'SYSTEM');
    });

    test('getThemeName and toKey serialize ThemeMode', () {
      expect(ThemeHelper.getThemeName(ThemeMode.light), 'LIGHT');
      expect(ThemeHelper.getThemeName(ThemeMode.dark), 'DARK');
      expect(ThemeHelper.getThemeName(ThemeMode.system), 'SYSTEM');

      expect(ThemeHelper.toKey(ThemeMode.light), 'LIGHT');
      expect(ThemeHelper.toKey(ThemeMode.dark), 'DARK');
      expect(ThemeHelper.toKey(ThemeMode.system), 'SYSTEM');
    });

    test('getThemeByName and fromKey deserialize strings', () {
      expect(ThemeHelper.getThemeByName('LIGHT'), ThemeMode.light);
      expect(ThemeHelper.getThemeByName('DARK'), ThemeMode.dark);
      expect(ThemeHelper.getThemeByName('SYSTEM'), ThemeMode.system);

      expect(ThemeHelper.getThemeByName(null), ExpressiveTheme.defaultTheme);
      expect(
        ThemeHelper.getThemeByName('invalid'),
        ExpressiveTheme.defaultTheme,
      );
      expect(
        ThemeHelper.getThemeByName('invalid', fallback: ThemeMode.light),
        ThemeMode.light,
      );

      expect(ThemeHelper.fromKey('light'), ThemeMode.light);
      expect(ThemeHelper.fromKey('dark'), ThemeMode.dark);
      expect(ThemeHelper.fromKey('system'), ThemeMode.system);
      expect(
        ThemeHelper.fromKey('unknown', fallback: ThemeMode.dark),
        ThemeMode.dark,
      );
    });

    test('ExpressiveThemeHelper typedef works identically', () {
      expect(ExpressiveThemeHelper.getThemeName(ThemeMode.light), 'LIGHT');
      expect(ExpressiveThemeHelper.getThemeByName('DARK'), ThemeMode.dark);
    });
  });
}
