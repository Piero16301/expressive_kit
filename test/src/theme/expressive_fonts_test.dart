import 'package:expressive_kit/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpressiveFonts', () {
    test('constants have correct package prefix and family names', () {
      expect(ExpressiveFonts.packageName, 'expressive_kit');
      expect(
        ExpressiveFonts.googleSansFlex,
        'packages/expressive_kit/GoogleSansFlex',
      );
      expect(
        ExpressiveFonts.merriweather,
        'packages/expressive_kit/Merriweather',
      );
      expect(ExpressiveFonts.montserrat, 'packages/expressive_kit/Montserrat');
      expect(ExpressiveFonts.nunito, 'packages/expressive_kit/Nunito');
      expect(ExpressiveFonts.openSans, 'packages/expressive_kit/OpenSans');
      expect(ExpressiveFonts.orbitron, 'packages/expressive_kit/Orbitron');
      expect(
        ExpressiveFonts.playfairDisplay,
        'packages/expressive_kit/PlayfairDisplay',
      );
      expect(ExpressiveFonts.roboto, 'packages/expressive_kit/Roboto');
      expect(
        ExpressiveFonts.sourceCodePro,
        'packages/expressive_kit/SourceCodePro',
      );
    });

    test('getAvailableFonts returns map of all 9 fonts', () {
      final fonts = ExpressiveFonts.getAvailableFonts();
      expect(fonts.length, 9);
      expect(fonts['Google Sans Flex'], ExpressiveFonts.googleSansFlex);
      expect(fonts['Merriweather'], ExpressiveFonts.merriweather);
      expect(fonts['Montserrat'], ExpressiveFonts.montserrat);
      expect(fonts['Nunito'], ExpressiveFonts.nunito);
      expect(fonts['Open Sans'], ExpressiveFonts.openSans);
      expect(fonts['Orbitron'], ExpressiveFonts.orbitron);
      expect(fonts['Playfair Display'], ExpressiveFonts.playfairDisplay);
      expect(fonts['Roboto'], ExpressiveFonts.roboto);
      expect(fonts['Source Code Pro'], ExpressiveFonts.sourceCodePro);
    });

    test('availableFonts static map contains expected entries', () {
      expect(ExpressiveFonts.availableFonts.length, 9);
      expect(
        ExpressiveFonts.availableFonts,
        equals(ExpressiveFonts.getAvailableFonts()),
      );
    });
  });
}
