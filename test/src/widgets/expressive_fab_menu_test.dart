import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpressiveFabMenu', () {
    testWidgets('toggles open/close and triggers item onTap', (tester) async {
      var itemTapped = false;
      final items = [
        ExpressiveFabMenuItem(
          icon: const Icon(Icons.share),
          label: 'Share',
          onTap: () => itemTapped = true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            floatingActionButton: ExpressiveFabMenu(
              items: items,
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              overlayColor: Colors.black54,
            ),
          ),
        ),
      );

      // Initially closed
      expect(find.text('Share'), findsNothing);

      // Open menu
      await tester.tap(find.byType(ExpressivePressable).first);
      await tester.pumpAndSettle();

      expect(find.text('Share'), findsOneWidget);

      // Tap menu item
      await tester.tap(find.byIcon(Icons.share));
      await tester.pumpAndSettle();

      expect(itemTapped, isTrue);
      // Closed after tapping item
      expect(find.text('Share'), findsNothing);
    });

    testWidgets('closes menu when tapping overlay', (tester) async {
      final items = [
        ExpressiveFabMenuItem(
          icon: const Icon(Icons.bookmark),
          label: 'Bookmark',
          onTap: () {},
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(floatingActionButton: ExpressiveFabMenu(items: items)),
        ),
      );

      // Open menu
      await tester.tap(find.byType(ExpressivePressable).first);
      await tester.pumpAndSettle();
      expect(find.text('Bookmark'), findsOneWidget);

      // Tap overlay
      final overlayFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.behavior == HitTestBehavior.translucent,
      );
      await tester.tap(overlayFinder);
      await tester.pumpAndSettle();

      expect(find.text('Bookmark'), findsNothing);
    });
  });
}
