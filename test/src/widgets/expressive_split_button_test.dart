import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveSplitButton', () {
    testWidgets('renders all variants enabled and disabled', (tester) async {
      for (final variant in ExpressiveButtonVariant.values) {
        // Enabled
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpressiveSplitButton(
                label: 'Action ${variant.name}',
                variant: variant,
                leadingIcon: const Icon(Icons.send),
                onPressed: () {},
                onTrailingPressed: () {},
              ),
            ),
          ),
        );
        expect(find.text('Action ${variant.name}'), findsOneWidget);

        // Disabled
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpressiveSplitButton(
                label: 'Disabled ${variant.name}',
                variant: variant,
                onPressed: null,
                onTrailingPressed: null,
              ),
            ),
          ),
        );
        expect(find.text('Disabled ${variant.name}'), findsOneWidget);
      }
    });

    testWidgets('triggers primary and trailing callbacks independently', (
      tester,
    ) async {
      var primaryPressed = false;
      var trailingPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveSplitButton(
              label: 'Save',
              borderRadius: BorderRadius.circular(16),
              trailingIcon: const Icon(Icons.arrow_drop_down),
              onPressed: () => primaryPressed = true,
              onTrailingPressed: () => trailingPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(primaryPressed, isTrue);

      await tester.tap(find.byIcon(Icons.arrow_drop_down));
      await tester.pumpAndSettle();
      expect(trailingPressed, isTrue);
    });
  });
}
