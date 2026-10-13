import 'package:expressive_kit/src/theme/theme.dart';
import 'package:material_ui/material_ui.dart';

/// Configuración de temas Material 3 Expressive para [expressive_kit].
abstract final class ExpressiveTheme {
  /// Genera el [ThemeData] para el modo claro.
  static ThemeData light({
    Color baseColor = Colors.blue,
    String fontFamily = ExpressiveFonts.googleSansFlex,
  }) {
    final colorScheme = ColorScheme.fromSeed(seedColor: baseColor);

    return _buildTheme(
      colorScheme: colorScheme,
      brightness: Brightness.light,
      fontFamily: fontFamily,
    );
  }

  /// Genera el [ThemeData] para el modo oscuro.
  static ThemeData dark({
    Color baseColor = Colors.blue,
    String fontFamily = ExpressiveFonts.googleSansFlex,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: baseColor,
      brightness: Brightness.dark,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      fontFamily: fontFamily,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Brightness brightness,
    String? fontFamily,
  }) {
    final baseTheme = brightness == Brightness.dark
        ? ThemeData.dark()
        : ThemeData.light();

    var textTheme = baseTheme.textTheme;
    if (fontFamily != null) {
      textTheme = textTheme.apply(fontFamily: fontFamily).applyFontVariations(
        const <FontVariation>[
          FontVariation('ROND', 100),
          FontVariation('wght', 500),
        ],
      );
    }

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      snackBarTheme: SnackBarThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        contentTextStyle: TextStyle(
          fontFamily: fontFamily,
          color: colorScheme.onSurface,
          fontVariations: const <FontVariation>[FontVariation('ROND', 100)],
        ),
        backgroundColor: colorScheme.surfaceContainer,
        closeIconColor: colorScheme.onSurface,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}

extension TextThemeFontVariations on TextTheme {
  TextTheme applyFontVariations(List<FontVariation> fontVariations) {
    return copyWith(
      displayLarge: displayLarge?.copyWith(fontVariations: fontVariations),
      displayMedium: displayMedium?.copyWith(fontVariations: fontVariations),
      displaySmall: displaySmall?.copyWith(fontVariations: fontVariations),
      headlineLarge: headlineLarge?.copyWith(fontVariations: fontVariations),
      headlineMedium: headlineMedium?.copyWith(fontVariations: fontVariations),
      headlineSmall: headlineSmall?.copyWith(fontVariations: fontVariations),
      titleLarge: titleLarge?.copyWith(fontVariations: fontVariations),
      titleMedium: titleMedium?.copyWith(fontVariations: fontVariations),
      titleSmall: titleSmall?.copyWith(fontVariations: fontVariations),
      bodyLarge: bodyLarge?.copyWith(fontVariations: fontVariations),
      bodyMedium: bodyMedium?.copyWith(fontVariations: fontVariations),
      bodySmall: bodySmall?.copyWith(fontVariations: fontVariations),
      labelLarge: labelLarge?.copyWith(fontVariations: fontVariations),
      labelMedium: labelMedium?.copyWith(fontVariations: fontVariations),
      labelSmall: labelSmall?.copyWith(fontVariations: fontVariations),
    );
  }
}
