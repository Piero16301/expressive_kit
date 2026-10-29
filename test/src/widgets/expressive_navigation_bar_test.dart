import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveNavigationBar', () {
    testWidgets('renders destinations with badges and handles selection', (
      tester,
    ) async {
      int selectedIndex = 0;
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
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                bottomNavigationBar: ExpressiveNavigationBar(
                  destinations: destinations,
                  selectedIndex: selectedIndex,
                  backgroundColor: Colors.white,
                  indicatorColor: Colors.blue.shade100,
                  height: 70,
                  onDestinationSelected: (idx) {
                    setState(() => selectedIndex = idx);
                  },
                ),
              );
            },
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

      // Tap Home to trigger transition from destination.icon back to destination.selectedIcon
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 0);
    });

    testWidgets(
      'maintains consistent top spacing for indicator across safe area padding',
      (tester) async {
        final destinations = [
          const ExpressiveNavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const ExpressiveNavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ];

        // 1. Without safe area padding (e.g. Desktop)
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(),
              child: Scaffold(
                bottomNavigationBar: ExpressiveNavigationBar(
                  destinations: destinations,
                  selectedIndex: 0,
                  onDestinationSelected: (_) {},
                ),
              ),
            ),
          ),
        );

        final navBarFinder = find.byType(ExpressiveNavigationBar);
        final navBarTopDesktop = tester.getTopLeft(navBarFinder).dy;
        final iconTopDesktop = tester.getTopLeft(find.byIcon(Icons.home)).dy;
        final distanceDesktop = iconTopDesktop - navBarTopDesktop;

        // 2. With safe area bottom padding (e.g. Mobile Android/iOS with gesture navigation)
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(padding: EdgeInsets.only(bottom: 34)),
              child: Scaffold(
                bottomNavigationBar: ExpressiveNavigationBar(
                  destinations: destinations,
                  selectedIndex: 0,
                  onDestinationSelected: (_) {},
                ),
              ),
            ),
          ),
        );

        final navBarTopMobile = tester.getTopLeft(navBarFinder).dy;
        final iconTopMobile = tester.getTopLeft(find.byIcon(Icons.home)).dy;
        final distanceMobile = iconTopMobile - navBarTopMobile;

        // The distance between the top of the NavigationBar and the item indicator/icon
        // must be identical on both desktop and mobile.
        expect(distanceMobile, equals(distanceDesktop));
      },
    );

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
