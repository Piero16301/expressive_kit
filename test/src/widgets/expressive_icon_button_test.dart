import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveIconButton', () {
    test('ExpressiveIconButtonSize properties', () {
      for (final size in ExpressiveIconButtonSize.values) {
        expect(size.diameter, greaterThan(0));
        expect(size.iconSize, greaterThan(0));
      }
    });

    testWidgets('renders all shapes and variants enabled and disabled', (
      tester,
    ) async {
      for (final variant in ExpressiveIconButtonVariant.values) {
        for (final shape in ExpressiveIconButtonShape.values) {
          // Enabled
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: ExpressiveIconButton(
                  icon: const Icon(Icons.favorite),
                  variant: variant,
                  shape: shape,
                  onPressed: () {},
                ),
              ),
            ),
          );
          expect(find.byIcon(Icons.favorite), findsOneWidget);

          // Disabled
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: ExpressiveIconButton(
                  icon: const Icon(Icons.favorite_border),
                  variant: variant,
                  shape: shape,
                  onPressed: null,
                ),
              ),
            ),
          );
          expect(find.byIcon(Icons.favorite_border), findsOneWidget);
        }
      }
    });

    testWidgets('named constructors construct circle and squircle', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ExpressiveIconButton.circle(
                  icon: const Icon(Icons.circle),
                  onPressed: () {},
                ),
                ExpressiveIconButton.squircle(
                  icon: const Icon(Icons.crop_square),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.circle), findsOneWidget);
      expect(find.byIcon(Icons.crop_square), findsOneWidget);
    });

    testWidgets('renders with badge dot and badge text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ExpressiveIconButton(
                  icon: const Icon(Icons.notifications),
                  showBadgeDot: true,
                  onPressed: () {},
                ),
                ExpressiveIconButton(
                  icon: const Icon(Icons.message),
                  badgeText: '9+',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.text('9+'), findsOneWidget);
    });

    testWidgets('renders with tooltip and triggers onPressed', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveIconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });
}
