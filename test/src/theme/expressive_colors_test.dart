import 'package:expressive_kit/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveColors', () {
    test('defaultColor is Colors.teal', () {
      expect(ExpressiveColors.defaultColor, Colors.teal);
    });

    test('palette contains all 19 defined colors', () {
      expect(ExpressiveColors.palette.length, 19);
      expect(ExpressiveColors.palette['RED'], Colors.red);
      expect(ExpressiveColors.palette['PINK'], Colors.pink);
      expect(ExpressiveColors.palette['PURPLE'], Colors.purple);
      expect(ExpressiveColors.palette['DEEP_PURPLE'], Colors.deepPurple);
      expect(ExpressiveColors.palette['INDIGO'], Colors.indigo);
      expect(ExpressiveColors.palette['BLUE'], Colors.blue);
      expect(ExpressiveColors.palette['LIGHT_BLUE'], Colors.lightBlue);
      expect(ExpressiveColors.palette['CYAN'], Colors.cyan);
      expect(ExpressiveColors.palette['TEAL'], Colors.teal);
      expect(ExpressiveColors.palette['GREEN'], Colors.green);
      expect(ExpressiveColors.palette['LIGHT_GREEN'], Colors.lightGreen);
      expect(ExpressiveColors.palette['LIME'], Colors.lime);
      expect(ExpressiveColors.palette['YELLOW'], Colors.yellow);
      expect(ExpressiveColors.palette['AMBER'], Colors.amber);
      expect(ExpressiveColors.palette['ORANGE'], Colors.orange);
      expect(ExpressiveColors.palette['DEEP_ORANGE'], Colors.deepOrange);
      expect(ExpressiveColors.palette['BROWN'], Colors.brown);
      expect(ExpressiveColors.palette['GREY'], Colors.grey);
      expect(ExpressiveColors.palette['BLUE_GREY'], Colors.blueGrey);
    });

    test(
      'fromKey returns matching color, defaultColor for null or unknown',
      () {
        expect(ExpressiveColors.fromKey('RED'), Colors.red);
        expect(ExpressiveColors.fromKey('red'), Colors.red);
        expect(ExpressiveColors.fromKey(null), ExpressiveColors.defaultColor);
        expect(
          ExpressiveColors.fromKey('NON_EXISTENT'),
          ExpressiveColors.defaultColor,
        );
      },
    );

    test('toKey returns key for palette colors and fallback for unknown', () {
      expect(ExpressiveColors.toKey(Colors.red), 'RED');
      expect(ExpressiveColors.toKey(Colors.teal), 'TEAL');
      expect(ExpressiveColors.toKey(Colors.green), 'GREEN');
      expect(ExpressiveColors.toKey(const Color(0xFF123456)), 'GREEN');
    });
  });
}
