import 'package:material_ui/material_ui.dart';

/// Colección y utilidades de idiomas soportados en [expressive_kit].
abstract final class ExpressiveLanguages {
  /// Locales individuales listos para usar.
  static const Locale english = Locale('en', 'US');
  static const Locale spanish = Locale('es', 'ES');
  static const Locale italian = Locale('it', 'IT');
  static const Locale german = Locale('de', 'DE');
  static const Locale french = Locale('fr', 'FR');
  static const Locale portuguese = Locale('pt', 'PT');

  /// Idioma predeterminado del paquete (inglés).
  static const Locale defaultLocale = english;

  /// Lista de idiomas disponibles y traducidos en el paquete.
  static const List<Locale> supportedLocales = <Locale>[
    english,
    spanish,
    italian,
    german,
    french,
    portuguese,
  ];

  /// Obtiene el [Locale] correspondiente a partir de un código de idioma (e.g. 'en', 'es', 'es_ES').
  /// Si es nulo o no se encuentra, retorna [defaultLocale].
  static Locale fromLanguageCode(String? code) {
    if (code == null) return defaultLocale;
    final normalized = code.toLowerCase().replaceAll('-', '_');
    for (final locale in supportedLocales) {
      final lang = locale.languageCode.toLowerCase();
      final full = '${lang}_${locale.countryCode?.toLowerCase()}';
      if (lang == normalized || full == normalized) {
        return locale;
      }
    }
    return defaultLocale;
  }
}

/// Alias para [ExpressiveLanguages].
typedef ExpressiveLocales = ExpressiveLanguages;
