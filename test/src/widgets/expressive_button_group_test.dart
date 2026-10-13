import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveButtonGroup', () {
    testWidgets('renders items with and without icons', (tester) async {
      int? selected;
      final items = [
        ExpressiveButtonGroupItem<int>(
          value: 1,
          label: 'Option 1',
          icon: const Icon(Icons.star),
        ),
        ExpressiveButtonGroupItem<int>(
          value: 2,
          label: 'Option 2',
          icon: const Icon(Icons.circle),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return ExpressiveButtonGroup<int>(
                  items: items,
                  selectedValue: selected ?? 1,
                  onSelected: (val) {
                    setState(() => selected = val);
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);

      // Tap option 2: option 1 becomes unselected with its icon rendered
      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();

      expect(selected, 2);
    });

    testWidgets(
      'renders correctly when isExpanded is false with custom styling',
      (tester) async {
        String? selected;
        final items = [
          ExpressiveButtonGroupItem<String>(
            value: 'A',
            label: 'Item A',
            icon: const Icon(Icons.check),
          ),
          ExpressiveButtonGroupItem<String>(value: 'B', label: 'Item B'),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return ExpressiveButtonGroup<String>(
                    items: items,
                    selectedValue: selected ?? 'B',
                    isExpanded: false,
                    height: 54,
                    backgroundColor: Colors.grey,
                    selectedColor: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                    onSelected: (val) {
                      setState(() => selected = val);
                    },
                  );
                },
              ),
            ),
          ),
        );

        expect(find.text('Item A'), findsOneWidget);
        expect(find.text('Item B'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);

        await tester.tap(find.text('Item A'));
        await tester.pumpAndSettle();

        expect(selected, 'A');
      },
    );
  });
}
