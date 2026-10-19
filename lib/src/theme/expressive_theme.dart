import 'package:expressive_kit/src/theme/theme.dart';
import 'package:material_ui/material_ui.dart';

/// Configuración de temas Material 3 Expressive para [expressive_kit].
abstract final class ExpressiveTheme {
  /// Modo de tema predeterminado.
  static const ThemeMode defaultTheme = ThemeMode.system;

  /// Clave para tema claro.
  static const String lightKey = 'LIGHT';

  /// Clave para tema oscuro.
  static const String darkKey = 'DARK';

  /// Clave para tema según el sistema.
  static const String systemKey = 'SYSTEM';

  /// Obtiene el [ThemeMode] a partir de su clave de texto (e.g. 'LIGHT', 'DARK', 'SYSTEM').
  ///
  /// La búsqueda es insensible a mayúsculas y minúsculas. Si [key] es nulo o
  /// desconocido, retorna [defaultTheme] ([ThemeMode.system]) o el [fallback] indicado.
  static ThemeMode fromKey(String? key, {ThemeMode fallback = defaultTheme}) {
    return switch (key?.toUpperCase()) {
      lightKey => ThemeMode.light,
      darkKey => ThemeMode.dark,
      systemKey => ThemeMode.system,
      _ => fallback,
    };
  }

  /// Obtiene la clave de texto estandarizada asociada a un [ThemeMode] ('LIGHT', 'DARK', 'SYSTEM').
  static String toKey(ThemeMode theme) {
    return switch (theme) {
      ThemeMode.light => lightKey,
      ThemeMode.dark => darkKey,
      ThemeMode.system => systemKey,
    };
  }

  /// Obtiene la clave de texto de un [ThemeMode] ('LIGHT', 'DARK', 'SYSTEM').
  ///
  /// Alias de [toKey] para compatibilidad con helpers de almacenamiento.
  static String getThemeName(ThemeMode theme) => toKey(theme);

  /// Obtiene el [ThemeMode] a partir de su nombre o clave de texto.
  ///
  /// Alias de [fromKey] para compatibilidad con helpers de almacenamiento.
  static ThemeMode getThemeByName(
    String? themeName, {
    ThemeMode fallback = defaultTheme,
  }) => fromKey(themeName, fallback: fallback);

  /// Genera el [ThemeData] para el modo claro.
  static ThemeData light({
    Color baseColor = ExpressiveColors.defaultColor,
    String fontFamily = ExpressiveFonts.defaultFont,
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
    Color baseColor = ExpressiveColors.defaultColor,
    String fontFamily = ExpressiveFonts.defaultFont,
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

/// Helper utilitario para persistencia y lectura de [ThemeMode] en almacenamiento local.
abstract final class ThemeHelper {
  /// Clave para tema claro ('LIGHT').
  static const String lightKey = ExpressiveTheme.lightKey;

  /// Clave para tema oscuro ('DARK').
  static const String darkKey = ExpressiveTheme.darkKey;

  /// Clave para tema según el sistema ('SYSTEM').
  static const String systemKey = ExpressiveTheme.systemKey;

  /// Retorna el nombre o clave de texto asociada a un [ThemeMode] ('LIGHT', 'DARK', 'SYSTEM').
  static String getThemeName(ThemeMode theme) => ExpressiveTheme.toKey(theme);

  /// Obtiene el [ThemeMode] a partir de su clave o nombre de texto.
  ///
  /// Si [themeName] es nulo o no coincide, retorna [ExpressiveTheme.defaultTheme]
  /// ([ThemeMode.system]) o el [fallback] indicado.
  static ThemeMode getThemeByName(
    String? themeName, {
    ThemeMode fallback = ExpressiveTheme.defaultTheme,
  }) => ExpressiveTheme.fromKey(themeName, fallback: fallback);

  /// Obtiene el [ThemeMode] a partir de su clave de texto.
  static ThemeMode fromKey(
    String? key, {
    ThemeMode fallback = ExpressiveTheme.defaultTheme,
  }) => ExpressiveTheme.fromKey(key, fallback: fallback);

  /// Obtiene la clave de texto estandarizada asociada a un [ThemeMode].
  static String toKey(ThemeMode theme) => ExpressiveTheme.toKey(theme);
}

/// Alias para [ThemeHelper].
typedef ExpressiveThemeHelper = ThemeHelper;
