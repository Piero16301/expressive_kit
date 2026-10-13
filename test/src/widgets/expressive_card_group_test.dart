import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveCard', () {
    testWidgets('renders child and handles onTap', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveCard(
              onTap: () => tapped = true,
              backgroundColor: Colors.amber,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(4),
              child: const Text('Card content'),
            ),
          ),
        ),
      );

      expect(find.text('Card content'), findsOneWidget);

      await tester.tap(find.text('Card content'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('renders without onTap without gesture detector', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ExpressiveCard(child: Text('Static card'))),
        ),
      );

      expect(find.text('Static card'), findsOneWidget);
    });
  });

  group('ExpressiveCardGroup', () {
    testWidgets('renders without title and with dividers', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpressiveCardGroup(
              showDividers: true,
              dividerIndent: 8,
              dividerEndIndent: 8,
              children: [Text('Row 1'), Text('Row 2'), Text('Row 3')],
            ),
          ),
        ),
      );

      expect(find.text('Row 1'), findsOneWidget);
      expect(find.text('Row 2'), findsOneWidget);
      expect(find.text('Row 3'), findsOneWidget);
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets(
      'renders with title, custom titlePadding, and without dividers',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpressiveCardGroup(
                title: 'Section Header',
                titlePadding: const EdgeInsets.all(12),
                backgroundColor: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),
                showDividers: false,
                children: const [Text('Item A'), Text('Item B')],
              ),
            ),
          ),
        );

        expect(find.text('Section Header'), findsOneWidget);
        expect(find.text('Item A'), findsOneWidget);
        expect(find.text('Item B'), findsOneWidget);
        expect(find.byType(Divider), findsNothing);
      },
    );
  });
}
