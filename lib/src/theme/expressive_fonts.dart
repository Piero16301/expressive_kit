/// Colección y utilidades de tipografías incluidas en [expressive_kit].
abstract final class ExpressiveFonts {
  /// Nombre del paquete para resolución de fuentes en Flutter.
  static const String packageName = 'expressive_kit';

  // Familias con prefijo de paquete para usar directamente en ThemeData / textTheme
  static const String googleSansFlex = 'packages/$packageName/GoogleSansFlex';
  static const String merriweather = 'packages/$packageName/Merriweather';
  static const String montserrat = 'packages/$packageName/Montserrat';
  static const String nunito = 'packages/$packageName/Nunito';
  static const String openSans = 'packages/$packageName/OpenSans';
  static const String orbitron = 'packages/$packageName/Orbitron';
  static const String playfairDisplay = 'packages/$packageName/PlayfairDisplay';
  static const String roboto = 'packages/$packageName/Roboto';
  static const String sourceCodePro = 'packages/$packageName/SourceCodePro';

  /// Retorna el mapa con los nombres legibles y sus identificadores de familia listos para Flutter.
  static Map<String, String> getAvailableFonts() {
    return {
      'Google Sans Flex': googleSansFlex,
      'Merriweather': merriweather,
      'Montserrat': montserrat,
      'Nunito': nunito,
      'Open Sans': openSans,
      'Orbitron': orbitron,
      'Playfair Display': playfairDisplay,
      'Roboto': roboto,
      'Source Code Pro': sourceCodePro,
    };
  }

  /// Mapa estático de acceso rápido.
  static final Map<String, String> availableFonts = getAvailableFonts();
}
