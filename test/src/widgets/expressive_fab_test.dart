import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveFab', () {
    test('ExpressiveFabSize properties', () {
      for (final size in ExpressiveFabSize.values) {
        expect(size.size, greaterThan(0));
        expect(size.iconSize, greaterThan(0));
        expect(size.borderRadius, greaterThan(0));
      }
    });

    testWidgets(
      'renders all sizes, enabled and disabled, with and without tooltip',
      (tester) async {
        var fabTapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              floatingActionButton: Column(
                children: [
                  ExpressiveFab(
                    icon: const Icon(Icons.add),
                    size: ExpressiveFabSize.small,
                    tooltip: 'Add item',
                    onPressed: () => fabTapped = true,
                  ),
                  const ExpressiveFab(
                    icon: Icon(Icons.edit),
                    size: ExpressiveFabSize.large,
                    elevation: 0,
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    onPressed: null, // disabled with custom colors
                  ),
                  const ExpressiveFab(
                    icon: Icon(Icons.check),
                    size: ExpressiveFabSize.regular,
                    onPressed: null, // disabled with default colors
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byIcon(Icons.edit), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        expect(fabTapped, isTrue);
      },
    );
  });

  group('ExpressiveExtendedFab', () {
    testWidgets('renders enabled and disabled, with and without tooltip', (
      tester,
    ) async {
      var extendedTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ExpressiveExtendedFab(
                  label: 'Compose',
                  icon: const Icon(Icons.email),
                  tooltip: 'Compose Email',
                  onPressed: () => extendedTapped = true,
                ),
                const ExpressiveExtendedFab(
                  label: 'Custom Disabled',
                  icon: Icon(Icons.block),
                  elevation: 0,
                  height: 48,
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  onPressed: null,
                ),
                const ExpressiveExtendedFab(
                  label: 'Default Disabled',
                  icon: Icon(Icons.close),
                  onPressed: null,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Compose'), findsOneWidget);
      expect(find.text('Custom Disabled'), findsOneWidget);
      expect(find.text('Default Disabled'), findsOneWidget);

      await tester.tap(find.text('Compose'));
      await tester.pumpAndSettle();

      expect(extendedTapped, isTrue);
    });
  });
}
