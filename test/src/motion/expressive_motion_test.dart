import 'package:expressive_kit/src/motion/motion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpressiveMotion tokens', () {
    test('constants have expected values', () {
      expect(ExpressiveMotion.springBouncy, isA<Cubic>());
      expect(ExpressiveMotion.springGentle, isA<Cubic>());
      expect(ExpressiveMotion.emphasized, Curves.easeInOutCubicEmphasized);
      expect(ExpressiveMotion.durationShort, const Duration(milliseconds: 200));
      expect(
        ExpressiveMotion.durationMedium,
        const Duration(milliseconds: 350),
      );
      expect(ExpressiveMotion.durationLong, const Duration(milliseconds: 500));
    });
  });

  group('ExpressivePressable', () {
    testWidgets('triggers onTap and scales down on tap down/up', (
      tester,
    ) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressivePressable(
              onTap: () => tapped = true,
              borderRadius: BorderRadius.circular(8),
              child: const Text('Press me'),
            ),
          ),
        ),
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.text('Press me')),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final transformFinder = find.ancestor(
        of: find.text('Press me'),
        matching: find.byType(Transform),
      );
      expect(transformFinder, findsWidgets);

      await gesture.up();
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('reverses animation on tap cancel', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressivePressable(
              onTap: () {},
              child: const Text('Cancel test'),
            ),
          ),
        ),
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.text('Cancel test')),
      );
      await tester.pump(const Duration(milliseconds: 50));
      await gesture.cancel();
      await tester.pumpAndSettle();
    });

    testWidgets('triggers onLongPress when provided', (tester) async {
      var longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressivePressable(
              onTap: () {},
              onLongPress: () => longPressed = true,
              child: const Text('Long press'),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('Long press'));
      await tester.pumpAndSettle();

      expect(longPressed, isTrue);
    });

    testWidgets('does not animate or trigger callbacks when disabled', (
      tester,
    ) async {
      var tapped = false;
      var longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressivePressable(
              enabled: false,
              onTap: () => tapped = true,
              onLongPress: () => longPressed = true,
              child: const Text('Disabled'),
            ),
          ),
        ),
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.text('Disabled')),
      );
      await tester.pump(const Duration(milliseconds: 50));
      await gesture.up();
      await tester.pumpAndSettle();

      expect(tapped, isFalse);
      expect(longPressed, isFalse);
    });

    testWidgets('does not animate if onTap is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ExpressivePressable(child: Text('No onTap'))),
        ),
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.text('No onTap')),
      );
      await tester.pump(const Duration(milliseconds: 50));
      await gesture.up();
      await tester.pumpAndSettle();
    });
  });
}
