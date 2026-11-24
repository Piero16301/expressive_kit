import 'package:expressive_kit/expressive_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveDropdownButton', () {
    const sampleItems = [
      ExpressiveDropdownItem<String>(
        value: 'living_room',
        label: 'Living Room',
        subtitle: '4 devices',
        icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01, strokeWidth: 2),
      ),
      ExpressiveDropdownItem<String>(
        value: 'office',
        label: 'Office',
        subtitle: '2 devices',
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedBriefcase01,
          strokeWidth: 2,
        ),
      ),
      ExpressiveDropdownItem<String>(
        value: 'garage',
        label: 'Garage',
        enabled: false,
      ),
    ];

    testWidgets(
      'renders label, hintText and placeholderIcon when value is null',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: ExpressiveDropdownButton<String>(
                label: 'Group',
                hintText: 'No group selected',
                placeholderIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedFolder01,
                ),
                items: sampleItems,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text('Group'), findsOneWidget);
        expect(find.text('No group selected'), findsOneWidget);
        expect(find.byType(ExpressiveCardGroup), findsOneWidget);
        expect(find.byType(ExpressiveBadge), findsOneWidget);
      },
    );

    testWidgets('opens modal bottom sheet, displays items and selects value', (
      tester,
    ) async {
      String? selected = 'living_room';

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: ExpressiveDropdownButton<String>(
                  label: 'Group',
                  modalTitle: 'Select a group',
                  value: selected,
                  items: sampleItems,
                  onChanged: (val) => setState(() => selected = val),
                ),
              );
            },
          ),
        ),
      );

      // Selected item label is shown as subtitle on the trigger
      expect(find.text('Living Room'), findsOneWidget);

      // Tap the dropdown card to open the modal bottom sheet
      await tester.tap(find.byType(ExpressiveListTile), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('Select a group'), findsOneWidget);
      expect(find.text('Office'), findsOneWidget);
      expect(find.text('4 devices'), findsOneWidget);
      expect(find.text('2 devices'), findsOneWidget);

      // Tap disabled item -> should not change selection or close sheet
      await tester.tap(find.text('Garage'));
      await tester.pumpAndSettle();
      expect(selected, 'living_room');
      expect(find.text('Select a group'), findsOneWidget);

      // Tap 'Office' -> updates value and closes modal
      await tester.tap(find.text('Office'));
      await tester.pumpAndSettle();

      expect(selected, 'office');
      expect(find.text('Select a group'), findsNothing);
      expect(find.text('Office'), findsOneWidget);
    });

    testWidgets('does not open modal when disabled or onChanged is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: const Scaffold(
            body: ExpressiveDropdownButton<String>(
              label: 'Group',
              modalTitle: 'Should not open',
              hintText: 'Disabled',
              items: sampleItems,
              onChanged: null,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ExpressiveListTile), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('Should not open'), findsNothing);
    });

    testWidgets('renders emptyText when items list is empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: ExpressiveDropdownButton<String>(
              label: 'Group',
              emptyText: 'No groups available',
              items: const [],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ExpressiveListTile), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('No groups available'), findsOneWidget);
    });

    testWidgets('renders errorText and supports showBadge: false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.dark(),
          home: Scaffold(
            body: ExpressiveDropdownButton<String>(
              label: 'Group',
              value: 'living_room',
              showBadge: false,
              errorText: 'Please choose a valid group',
              items: sampleItems,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(ExpressiveBadge), findsNothing);
      expect(find.text('Please choose a valid group'), findsOneWidget);
    });

    testWidgets(
      'renders disabled state with icon both with and without badge',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: Column(
                children: [
                  ExpressiveDropdownButton<String>(
                    label: 'Disabled Badge',
                    value: 'living_room',
                    enabled: false,
                    showBadge: true,
                    items: sampleItems,
                    onChanged: (_) {},
                  ),
                  ExpressiveDropdownButton<String>(
                    label: 'Disabled No Badge',
                    value: 'office',
                    enabled: false,
                    showBadge: false,
                    items: sampleItems,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Disabled Badge'), findsOneWidget);
        expect(find.text('Living Room'), findsOneWidget);
        expect(find.text('Disabled No Badge'), findsOneWidget);
        expect(find.text('Office'), findsOneWidget);
        expect(find.byType(ExpressiveBadge), findsOneWidget);
      },
    );

    testWidgets(
      'instantiates non-const ExpressiveDropdownItem and handles unknown value',
      (tester) async {
        final dynamicValue = 'dynamic_${1}';
        final items = [
          ExpressiveDropdownItem<String>(value: dynamicValue, label: 'Dynamic'),
        ];

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: ExpressiveDropdownButton<String>(
                label: 'Group',
                value: 'unknown',
                hintText: 'Fallback',
                items: items,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text('Fallback'), findsOneWidget);
      },
    );
  });
}
