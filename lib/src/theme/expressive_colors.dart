import 'package:material_ui/material_ui.dart';

/// Paleta de colores predeterminados para temas dinámicos en ExpressiveKit.
abstract final class ExpressiveColors {
  /// Color base predeterminado.
  static const Color defaultColor = Colors.teal;

  /// Mapa de colores disponibles con sus claves identificadoras estandarizadas.
  static const Map<String, Color> palette = <String, Color>{
    'RED': Colors.red,
    'PINK': Colors.pink,
    'PURPLE': Colors.purple,
    'DEEP_PURPLE': Colors.deepPurple,
    'INDIGO': Colors.indigo,
    'BLUE': Colors.blue,
    'LIGHT_BLUE': Colors.lightBlue,
    'CYAN': Colors.cyan,
    'TEAL': Colors.teal,
    'GREEN': Colors.green,
    'LIGHT_GREEN': Colors.lightGreen,
    'LIME': Colors.lime,
    'YELLOW': Colors.yellow,
    'AMBER': Colors.amber,
    'ORANGE': Colors.orange,
    'DEEP_ORANGE': Colors.deepOrange,
    'BROWN': Colors.brown,
    'GREY': Colors.grey,
    'BLUE_GREY': Colors.blueGrey,
  };

  /// Obtiene el color a partir de su clave de texto (e.g. 'GREEN', 'RED').
  static Color fromKey(String? key) {
    if (key == null) return defaultColor;
    return palette[key.toUpperCase()] ?? defaultColor;
  }

  /// Obtiene la clave asociada a un [Color].
  static String toKey(Color color) {
    for (final entry in palette.entries) {
      if (entry.value.toARGB32() == color.toARGB32()) {
        return entry.key;
      }
    }
    return 'GREEN';
  }
}
