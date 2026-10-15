import 'package:expressive_kit/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveLanguages', () {
    test('constants have correct language and country codes', () {
      expect(ExpressiveLanguages.english, const Locale('en', 'US'));
      expect(ExpressiveLanguages.spanish, const Locale('es', 'ES'));
      expect(ExpressiveLanguages.italian, const Locale('it', 'IT'));
      expect(ExpressiveLanguages.german, const Locale('de', 'DE'));
      expect(ExpressiveLanguages.french, const Locale('fr', 'FR'));
      expect(ExpressiveLanguages.portuguese, const Locale('pt', 'PT'));
    });

    test('defaultLocale is english', () {
      expect(ExpressiveLanguages.defaultLocale, ExpressiveLanguages.english);
    });

    test('supportedLocales contains all 6 languages', () {
      expect(ExpressiveLanguages.supportedLocales.length, 6);
      expect(
        ExpressiveLanguages.supportedLocales,
        containsAll(<Locale>[
          ExpressiveLanguages.english,
          ExpressiveLanguages.spanish,
          ExpressiveLanguages.italian,
          ExpressiveLanguages.german,
          ExpressiveLanguages.french,
          ExpressiveLanguages.portuguese,
        ]),
      );
    });

    test(
      'fromLanguageCode resolves matching locale or returns defaultLocale',
      () {
        expect(
          ExpressiveLanguages.fromLanguageCode('en'),
          ExpressiveLanguages.english,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode('en_US'),
          ExpressiveLanguages.english,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode('en-us'),
          ExpressiveLanguages.english,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode('es'),
          ExpressiveLanguages.spanish,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode('es_ES'),
          ExpressiveLanguages.spanish,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode('it'),
          ExpressiveLanguages.italian,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode('de'),
          ExpressiveLanguages.german,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode('fr'),
          ExpressiveLanguages.french,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode('pt'),
          ExpressiveLanguages.portuguese,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode(null),
          ExpressiveLanguages.defaultLocale,
        );
        expect(
          ExpressiveLanguages.fromLanguageCode('ja'),
          ExpressiveLanguages.defaultLocale,
        );
      },
    );

    test('ExpressiveLocales alias matches ExpressiveLanguages', () {
      expect(
        ExpressiveLocales.supportedLocales,
        ExpressiveLanguages.supportedLocales,
      );
      expect(
        ExpressiveLocales.defaultLocale,
        ExpressiveLanguages.defaultLocale,
      );
    });
  });
}
