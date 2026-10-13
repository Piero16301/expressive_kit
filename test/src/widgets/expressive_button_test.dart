import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveButton', () {
    test('ExpressiveButtonSize properties', () {
      for (final size in ExpressiveButtonSize.values) {
        expect(size.height, greaterThan(0));
        expect(size.iconSize, greaterThan(0));
        expect(size.horizontalPadding, greaterThan(0));
        expect(size.fontSize, greaterThan(0));
      }
    });

    testWidgets('renders all variants enabled and disabled', (tester) async {
      for (final variant in ExpressiveButtonVariant.values) {
        // Enabled
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpressiveButton(
                label: 'Button ${variant.name}',
                variant: variant,
                onPressed: () {},
              ),
            ),
          ),
        );
        expect(find.text('Button ${variant.name}'), findsOneWidget);

        // Disabled
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpressiveButton(
                label: 'Disabled ${variant.name}',
                variant: variant,
                onPressed: null,
              ),
            ),
          ),
        );
        expect(find.text('Disabled ${variant.name}'), findsOneWidget);
      }
    });

    testWidgets('named constructors construct correct variants', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ExpressiveButton.filled(label: 'Filled', onPressed: () {}),
                ExpressiveButton.tonal(label: 'Tonal', onPressed: () {}),
                ExpressiveButton.outlined(label: 'Outlined', onPressed: () {}),
                ExpressiveButton.elevated(label: 'Elevated', onPressed: () {}),
                ExpressiveButton.text(label: 'Text', onPressed: () {}),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Filled'), findsOneWidget);
      expect(find.text('Tonal'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
      expect(find.text('Elevated'), findsOneWidget);
      expect(find.text('Text'), findsOneWidget);
    });

    testWidgets('renders with icons and trailingIcons', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveButton(
              label: 'With Icons',
              icon: const Icon(Icons.star),
              trailingIcon: const Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('With Icons'), findsOneWidget);
    });

    testWidgets(
      'shows loading indicator and hides icons when isLoading is true',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpressiveButton(
                label: 'Loading Button',
                isLoading: true,
                icon: const Icon(Icons.star),
                trailingIcon: const Icon(Icons.arrow_forward),
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byIcon(Icons.star), findsNothing);
        expect(find.byIcon(Icons.arrow_forward), findsNothing);
      },
    );

    testWidgets('renders isExpanded with full width', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: ExpressiveButton(
                  label: 'Expanded',
                  isExpanded: true,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      );

      final size = tester.getSize(find.byType(ExpressiveButton));
      expect(size.width, 300);
    });

    testWidgets('applies custom styling colors and border radius', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveButton(
              label: 'Custom',
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              size: ExpressiveButtonSize.large,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Custom'), findsOneWidget);
    });

    testWidgets('triggers onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveButton(
              label: 'Tap Me',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });
}
