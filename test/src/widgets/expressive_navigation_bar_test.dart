import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveNavigationBar', () {
    testWidgets('renders destinations with badges and handles selection', (
      tester,
    ) async {
      int? selectedIndex;
      final destinations = [
        ExpressiveNavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: 'Home',
        ),
        ExpressiveNavigationDestination(
          icon: const Icon(Icons.notifications_outlined),
          label: 'Notifications',
          showBadgeDot: true,
        ),
        ExpressiveNavigationDestination(
          icon: const Icon(Icons.mail_outlined),
          label: 'Mail',
          badgeText: '5',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ExpressiveNavigationBar(
              destinations: destinations,
              selectedIndex: 0,
              backgroundColor: Colors.white,
              indicatorColor: Colors.blue.shade100,
              height: 70,
              onDestinationSelected: (idx) => selectedIndex = idx,
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Mail'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);

      await tester.tap(find.text('Notifications'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    });

    test('asserts when selectedIndex is invalid', () {
      expect(
        () => ExpressiveNavigationBar(
          destinations: [
            ExpressiveNavigationDestination(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
          ],
          selectedIndex: 5,
          onDestinationSelected: (_) {},
        ),
        throwsAssertionError,
      );
    });
  });
}
