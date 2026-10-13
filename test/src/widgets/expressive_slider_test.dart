import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveSlider', () {
    test('assertions for min, max, value', () {
      expect(
        () => ExpressiveSlider(value: 10, min: 20, max: 10, onChanged: (_) {}),
        throwsAssertionError,
      );
      expect(
        () => ExpressiveSlider(value: 25, min: 0, max: 10, onChanged: (_) {}),
        throwsAssertionError,
      );
    });

    testWidgets('renders title, subtitle, divisions, and custom styling', (
      tester,
    ) async {
      double currentVal = 50;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveSlider(
              value: currentVal,
              min: 0,
              max: 100,
              divisions: 5,
              title: 'Volume',
              subtitle: 'Current level',
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              thumbColor: Colors.blueAccent,
              trackHeight: 20,
              thumbWidth: 18,
              thumbHeight: 40,
              onChanged: (val) => currentVal = val,
            ),
          ),
        ),
      );

      expect(find.text('Volume'), findsOneWidget);
      expect(find.text('Current level'), findsOneWidget);
    });

    testWidgets('stepper buttons increment and decrement value', (
      tester,
    ) async {
      double currentVal = 50;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return ExpressiveSlider(
                  value: currentVal,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (val) => setState(() => currentVal = val),
                );
              },
            ),
          ),
        ),
      );

      // Tap step down (-)
      final minusFinder = find.byType(ExpressiveIconButton).first;
      await tester.tap(minusFinder);
      await tester.pumpAndSettle();
      expect(currentVal, 40);

      // Tap step up (+)
      final plusFinder = find.byType(ExpressiveIconButton).last;
      await tester.tap(plusFinder);
      await tester.pumpAndSettle();
      expect(currentVal, 50);
    });

    testWidgets('stepper buttons without divisions use 10% range', (
      tester,
    ) async {
      double currentVal = 50;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return ExpressiveSlider(
                  value: currentVal,
                  min: 0,
                  max: 100,
                  onChanged: (val) => setState(() => currentVal = val),
                );
              },
            ),
          ),
        ),
      );

      final minusFinder = find.byType(ExpressiveIconButton).first;
      await tester.tap(minusFinder);
      await tester.pumpAndSettle();
      expect(currentVal, 40);

      final plusFinder = find.byType(ExpressiveIconButton).last;
      await tester.tap(plusFinder);
      await tester.pumpAndSettle();
      expect(currentVal, 50);
    });

    testWidgets('tap and drag interactions update value', (tester) async {
      double currentVal = 0.5;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return ExpressiveSlider(
                      value: currentVal,
                      min: 0,
                      max: 1,
                      showSteppers: false,
                      onChanged: (val) => setState(() => currentVal = val),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Tap down on the gesture detector
      final gestureFinder = find.byType(GestureDetector).last;
      await tester.tapAt(
        tester.getTopLeft(gestureFinder) + const Offset(50, 10),
      );
      await tester.pumpAndSettle();

      // Drag
      await tester.drag(gestureFinder, const Offset(60, 0));
      await tester.pumpAndSettle();

      expect(currentVal, greaterThan(0.5));
    });

    testWidgets('tap and drag with divisions snaps to steps', (tester) async {
      double currentVal = 20;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return ExpressiveSlider(
                      value: currentVal,
                      min: 0,
                      max: 100,
                      divisions: 5,
                      showSteppers: false,
                      onChanged: (val) => setState(() => currentVal = val),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      final gestureFinder = find.byType(GestureDetector).last;
      await tester.tapAt(
        tester.getTopLeft(gestureFinder) + const Offset(150, 10),
      );
      await tester.pumpAndSettle();

      final gesture = await tester.startGesture(
        tester.getCenter(gestureFinder),
      );
      await gesture.moveBy(const Offset(50, 0));
      await tester.pumpAndSettle();
      await gesture.up();
      await tester.pumpAndSettle();

      expect(currentVal, greaterThan(20));
    });

    testWidgets('handles drag cancel and disabled state without onChanged', (
      tester,
    ) async {
      double currentVal = 0.5;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return ExpressiveSlider(
                    value: currentVal,
                    min: 0,
                    max: 1,
                    onChanged: (val) => setState(() => currentVal = val),
                  );
                },
              ),
            ),
          ),
        ),
      );

      final gestureFinder = find.byType(GestureDetector).last;
      final gesture = await tester.startGesture(
        tester.getCenter(gestureFinder),
      );
      await tester.pump(const Duration(milliseconds: 50));
      await gesture.cancel();
      await tester.pumpAndSettle();

      // Disabled state
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: ExpressiveSlider(
                value: 0.5,
                min: 0,
                max: 1,
                onChanged: null, // disabled
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ExpressiveSlider), findsOneWidget);
    });

    testWidgets('supports min == max edge case without division by zero', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveSlider(
              value: 10,
              min: 10,
              max: 10,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(ExpressiveSlider), findsOneWidget);
    });
  });
}
