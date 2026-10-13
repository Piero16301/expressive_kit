import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveSearchBar', () {
    testWidgets('editable mode handles text entry and callbacks', (
      tester,
    ) async {
      String? changed;
      String? submitted;
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveSearchBar(
              hintText: 'Search...',
              leading: const Icon(Icons.search),
              trailing: const Icon(Icons.mic),
              onChanged: (val) => changed = val,
              onSubmitted: (val) => submitted = val,
              onTap: () => tapped = true,
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.mic), findsOneWidget);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);

      await tester.enterText(find.byType(TextField), 'Hello');
      expect(changed, 'Hello');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      expect(submitted, 'Hello');
    });

    testWidgets('readOnly mode renders text and handles onTap when provided', (
      tester,
    ) async {
      var searchBarTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveSearchBar(
              readOnly: true,
              hintText: 'Click to search',
              onTap: () => searchBarTapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Click to search'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);

      await tester.tap(find.text('Click to search'));
      await tester.pumpAndSettle();

      expect(searchBarTapped, isTrue);
    });

    testWidgets('readOnly mode without onTap renders static container', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpressiveSearchBar(
              readOnly: true,
              hintText: 'Static search',
            ),
          ),
        ),
      );

      expect(find.text('Static search'), findsOneWidget);
      expect(find.byType(ExpressivePressable), findsNothing);
    });
  });
}
