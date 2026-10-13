import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpressiveSwitch', () {
    testWidgets('toggles value when tapped and animates on widget update', (
      tester,
    ) async {
      bool currentVal = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return ExpressiveSwitch(
                  value: currentVal,
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Colors.grey,
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: Colors.black,
                  onChanged: (val) => setState(() => currentVal = val),
                );
              },
            ),
          ),
        ),
      );

      expect(currentVal, isFalse);

      await tester.tap(find.byType(ExpressiveSwitch));
      await tester.pumpAndSettle();

      expect(currentVal, isTrue);

      // Tap again to toggle back
      await tester.tap(find.byType(ExpressiveSwitch));
      await tester.pumpAndSettle();

      expect(currentVal, isFalse);
    });

    testWidgets('renders disabled state and without icons', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpressiveSwitch(
              value: true,
              showIcons: false,
              onChanged: null, // disabled
            ),
          ),
        ),
      );

      expect(find.byType(ExpressiveSwitch), findsOneWidget);
    });

    testWidgets('renders with custom active and inactive icons', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpressiveSwitch(
              value: true,
              activeThumbIcon: Icon(Icons.check),
              inactiveThumbIcon: Icon(Icons.close),
              onChanged: null,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });
}
