import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveTopAppBar', () {
    testWidgets('renders standard app bar with custom settings', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: ExpressiveTopAppBar(
              title: const Text('Top Bar'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 2,
              centerTitle: true,
              toolbarHeight: 64,
              titleSpacing: 20,
            ),
          ),
        ),
      );

      expect(find.text('Top Bar'), findsOneWidget);
      expect(find.byIcon(Icons.more_horiz), findsOneWidget);

      final appBar = tester.widget<ExpressiveTopAppBar>(
        find.byType(ExpressiveTopAppBar),
      );
      expect(appBar.preferredSize.height, 64);
    });

    testWidgets('shows automatic back button when navigator can pop', (
      tester,
    ) async {
      var backTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  child: const Text('Go to page 2'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return Scaffold(
                            appBar: ExpressiveTopAppBar(
                              title: const Text('Page 2'),
                              onBack: () => backTapped = true,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Go to page 2'));
      await tester.pumpAndSettle();

      expect(find.text('Page 2'), findsOneWidget);
      expect(find.byType(ExpressiveIconButton), findsOneWidget);

      await tester.tap(find.byType(ExpressiveIconButton));
      await tester.pumpAndSettle();

      expect(backTapped, isTrue);
    });

    testWidgets('default onBack calls maybePop when back button tapped', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  child: const Text('Go to page 2'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return const Scaffold(
                            appBar: ExpressiveTopAppBar(title: Text('Page 2')),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Go to page 2'));
      await tester.pumpAndSettle();

      expect(find.text('Page 2'), findsOneWidget);

      await tester.tap(find.byType(ExpressiveIconButton));
      await tester.pumpAndSettle();

      expect(find.text('Page 2'), findsNothing);
    });

    testWidgets('large constructor renders large title and custom leading', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: ExpressiveTopAppBar.large(
              titleText: 'Large Title',
              leading: const Icon(Icons.menu),
              actions: const [Icon(Icons.search)],
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      );

      expect(find.text('Large Title'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      final appBar = tester.widget<ExpressiveTopAppBar>(
        find.byType(ExpressiveTopAppBar),
      );
      expect(appBar.preferredSize.height, 136);
    });
  });
}
