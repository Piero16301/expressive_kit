import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveBadge', () {
    testWidgets('renders icon with default and custom colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveBadge(
              icon: const Icon(Icons.star),
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              size: 48,
              iconSize: 24,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  group('ExpressiveListTile', () {
    testWidgets(
      'renders title, subtitle, leading, trailing and handles onTap',
      (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpressiveListTile(
                title: const Text('Title'),
                subtitle: const Text('Subtitle'),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Subtitle'), findsOneWidget);
        expect(find.byIcon(Icons.person), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);

        await tester.tap(find.text('Title'));
        await tester.pumpAndSettle();

        expect(tapped, isTrue);
      },
    );

    testWidgets('renders disabled state correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpressiveListTile(
              title: Text('Disabled Tile'),
              subtitle: Text('Disabled Subtitle'),
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.text('Disabled Tile'), findsOneWidget);
      expect(find.text('Disabled Subtitle'), findsOneWidget);
    });

    testWidgets('renders split action with divider', (tester) async {
      var trailingTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveListTile(
              title: const Text('Split Tile'),
              trailing: const Icon(Icons.arrow_forward),
              secondaryTrailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => trailingTapped = true,
              ),
              showSplitDivider: true,
            ),
          ),
        ),
      );

      expect(find.text('Split Tile'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
      expect(find.byType(VerticalDivider), findsOneWidget);

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      expect(trailingTapped, isTrue);
    });

    testWidgets('switchTile factory toggles switch when tapped', (
      tester,
    ) async {
      var switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return ExpressiveListTile.switchTile(
                  title: const Text('Switch Tile'),
                  value: switchValue,
                  onChanged: (val) => setState(() => switchValue = val),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Switch Tile'), findsOneWidget);
      expect(find.byType(ExpressiveSwitch), findsOneWidget);

      // Tapping the tile toggles switch
      await tester.tap(find.text('Switch Tile'));
      await tester.pumpAndSettle();

      expect(switchValue, isTrue);
    });

    testWidgets('switchTile factory with showChevronWithSwitch and onTap', (
      tester,
    ) async {
      var tileTapped = false;
      var switchVal = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveListTile.switchTile(
              title: const Text('Advanced Switch Tile'),
              subtitle: const Text('With Chevron'),
              value: switchVal,
              showChevronWithSwitch: true,
              onTap: () => tileTapped = true,
              onChanged: (val) => switchVal = val,
            ),
          ),
        ),
      );

      expect(find.text('Advanced Switch Tile'), findsOneWidget);
      expect(find.byType(VerticalDivider), findsOneWidget);

      await tester.tap(find.text('Advanced Switch Tile'));
      await tester.pumpAndSettle();

      expect(tileTapped, isTrue);
    });
  });
}
