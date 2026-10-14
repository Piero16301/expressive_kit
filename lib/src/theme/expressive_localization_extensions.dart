import 'package:material_ui/material_ui.dart';

import '../l10n/generated/expressive_localizations.dart';
import 'expressive_colors.dart';

extension ExpressiveThemeModeX on ThemeMode {
  /// Retorna el nombre traducido del modo de tema.
  String localizedName(BuildContext context) {
    final l10n = ExpressiveLocalizations.of(context);
    return switch (this) {
      ThemeMode.light => l10n?.themeLight ?? 'Light',
      ThemeMode.dark => l10n?.themeDark ?? 'Dark',
      ThemeMode.system => l10n?.themeSystem ?? 'System',
    };
  }
}

extension ExpressiveLocaleX on Locale {
  /// Retorna el nombre traducido del idioma.
  String localizedName(BuildContext context) {
    final l10n = ExpressiveLocalizations.of(context);
    return switch (languageCode) {
      'en' => l10n?.languageEnglish ?? 'English',
      'es' => l10n?.languageSpanish ?? 'Español',
      'it' => l10n?.languageItalian ?? 'Italiano',
      'de' => l10n?.languageGerman ?? 'Deutsch',
      'fr' => l10n?.languageFrench ?? 'Français',
      'pt' => l10n?.languagePortuguese ?? 'Português',
      _ => languageCode,
    };
  }
}

extension ExpressiveColorX on Color {
  /// Retorna el nombre traducido del color.
  String localizedName(BuildContext context) {
    final key = ExpressiveColors.toKey(this);
    final l10n = ExpressiveLocalizations.of(context);
    if (l10n == null) return key;

    return switch (key) {
      'RED' => l10n.colorRed,
      'PINK' => l10n.colorPink,
      'PURPLE' => l10n.colorPurple,
      'DEEP_PURPLE' => l10n.colorDeepPurple,
      'INDIGO' => l10n.colorIndigo,
      'BLUE' => l10n.colorBlue,
      'LIGHT_BLUE' => l10n.colorLightBlue,
      'CYAN' => l10n.colorCyan,
      'TEAL' => l10n.colorTeal,
      'GREEN' => l10n.colorGreen,
      'LIGHT_GREEN' => l10n.colorLightGreen,
      'LIME' => l10n.colorLime,
      'YELLOW' => l10n.colorYellow,
      'AMBER' => l10n.colorAmber,
      'ORANGE' => l10n.colorOrange,
      'DEEP_ORANGE' => l10n.colorDeepOrange,
      'BROWN' => l10n.colorBrown,
      'GREY' => l10n.colorGrey,
      'BLUE_GREY' => l10n.colorBlueGrey,
      _ => key,
    };
  }
}
