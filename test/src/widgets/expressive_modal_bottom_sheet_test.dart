import 'package:expressive_kit/expressive_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('showExpressiveModalBottomSheet', () {
    testWidgets('renders title, drag handle, itemsBuilder and returns result', (
      tester,
    ) async {
      String? result;

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    result = await showExpressiveModalBottomSheet<String>(
                      context: context,
                      title: 'Choose Option',
                      itemsBuilder: (modalContext) => [
                        ListTile(
                          title: const Text('Option A'),
                          onTap: () => Navigator.pop(modalContext, 'A'),
                        ),
                      ],
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Choose Option'), findsOneWidget);
      expect(find.text('Option A'), findsOneWidget);

      await tester.tap(find.text('Option A'));
      await tester.pumpAndSettle();

      expect(result, 'A');
      expect(find.text('Choose Option'), findsNothing);
    });

    testWidgets(
      'renders custom builder without title or drag handle and custom colors',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.dark(),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      showExpressiveModalBottomSheet<void>(
                        context: context,
                        showDragHandle: false,
                        maxHeightFraction: 0.5,
                        backgroundColor: Colors.indigo,
                        builder: (_) => const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Custom Body'),
                        ),
                      );
                    },
                    child: const Text('Open Custom'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open Custom'));
        await tester.pumpAndSettle();

        expect(find.text('Custom Body'), findsOneWidget);
      },
    );
  });
}
