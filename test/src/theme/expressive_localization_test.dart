import 'package:expressive_kit/src/l10n/generated/expressive_localizations.dart';
import 'package:expressive_kit/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  final delegates = [
    ...ExpressiveLocalizations.localizationsDelegates,
    ...GlobalMaterialLocalizations.delegates,
  ];

  group('ExpressiveLocalizationExtensions', () {
    testWidgets('ExpressiveLocaleX returns correct names with localizations', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: delegates,
          supportedLocales: ExpressiveLocalizations.supportedLocales,
          locale: const Locale('es'),
          home: Builder(
            builder: (context) {
              expect(const Locale('en').localizedName(context), 'Inglés');
              expect(const Locale('es').localizedName(context), 'Español');
              expect(const Locale('it').localizedName(context), 'Italiano');
              expect(const Locale('de').localizedName(context), 'Alemán');
              expect(const Locale('fr').localizedName(context), 'Francés');
              expect(const Locale('pt').localizedName(context), 'Portugués');
              expect(const Locale('ja').localizedName(context), 'ja');
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('ExpressiveLocaleX in Italian returns correct names', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: delegates,
          supportedLocales: ExpressiveLocalizations.supportedLocales,
          locale: const Locale('it'),
          home: Builder(
            builder: (context) {
              expect(const Locale('it').localizedName(context), 'Italiano');
              expect(const Locale('de').localizedName(context), 'Tedesco');
              expect(const Locale('fr').localizedName(context), 'Francese');
              expect(const Locale('pt').localizedName(context), 'Portoghese');
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('ExpressiveThemeModeX returns correct localized names', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: delegates,
          supportedLocales: ExpressiveLocalizations.supportedLocales,
          locale: const Locale('es'),
          home: Builder(
            builder: (context) {
              expect(ThemeMode.light.localizedName(context), 'Claro');
              expect(ThemeMode.dark.localizedName(context), 'Oscuro');
              expect(ThemeMode.system.localizedName(context), 'Sistema');
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets(
      'ExpressiveColorX returns all localized color names in Spanish',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: delegates,
            supportedLocales: ExpressiveLocalizations.supportedLocales,
            locale: const Locale('es'),
            home: Builder(
              builder: (context) {
                expect(Colors.red.localizedName(context), 'Rojo');
                expect(Colors.pink.localizedName(context), 'Rosa');
                expect(Colors.purple.localizedName(context), 'Púrpura');
                expect(
                  Colors.deepPurple.localizedName(context),
                  'Púrpura oscuro',
                );
                expect(Colors.indigo.localizedName(context), 'Índigo');
                expect(Colors.blue.localizedName(context), 'Azul');
                expect(Colors.lightBlue.localizedName(context), 'Azul claro');
                expect(Colors.cyan.localizedName(context), 'Cian');
                expect(Colors.teal.localizedName(context), 'Turquesa');
                expect(Colors.green.localizedName(context), 'Verde');
                expect(Colors.lightGreen.localizedName(context), 'Verde claro');
                expect(Colors.lime.localizedName(context), 'Lima');
                expect(Colors.yellow.localizedName(context), 'Amarillo');
                expect(Colors.amber.localizedName(context), 'Ámbar');
                expect(Colors.orange.localizedName(context), 'Naranja');
                expect(
                  Colors.deepOrange.localizedName(context),
                  'Naranja oscuro',
                );
                expect(Colors.brown.localizedName(context), 'Marrón');
                expect(Colors.grey.localizedName(context), 'Gris');
                expect(Colors.blueGrey.localizedName(context), 'Gris azulado');
                return const SizedBox();
              },
            ),
          ),
        );
      },
    );

    testWidgets('Extensions fall back to default strings when l10n is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ThemeMode.light.localizedName(context), 'Light');
              expect(ThemeMode.dark.localizedName(context), 'Dark');
              expect(ThemeMode.system.localizedName(context), 'System');

              expect(const Locale('en').localizedName(context), 'English');
              expect(const Locale('es').localizedName(context), 'Español');
              expect(const Locale('it').localizedName(context), 'Italiano');
              expect(const Locale('de').localizedName(context), 'Deutsch');
              expect(const Locale('fr').localizedName(context), 'Français');
              expect(const Locale('pt').localizedName(context), 'Português');
              expect(const Locale('ja').localizedName(context), 'ja');

              expect(Colors.red.localizedName(context), 'RED');
              expect(Colors.teal.localizedName(context), 'TEAL');
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
