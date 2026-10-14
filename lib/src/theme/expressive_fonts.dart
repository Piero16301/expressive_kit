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

  /// Tipografía base predeterminada.
  static const String defaultFont = googleSansFlex;

  /// Mapa de fuentes disponibles con nombres legibles e identificadores de familia listos para Flutter.
  static const Map<String, String> availableFonts = <String, String>{
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
