import 'package:expressive_kit/expressive_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveSnackBar', () {
    testWidgets('renders all semantic types, title, action and close button', (
      tester,
    ) async {
      var actionTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => Column(
                children: [
                  for (final type in ExpressiveSnackBarType.values)
                    ElevatedButton(
                      onPressed: () {
                        showExpressiveSnackBar(
                          context: context,
                          title: 'Title ${type.name}',
                          message: 'Message ${type.name}',
                          type: type,
                          actionLabel: 'Retry',
                          onAction: () => actionTapped = true,
                          showCloseIcon: true,
                        );
                      },
                      child: Text(type.name),
                    ),
                ],
              ),
            ),
          ),
        ),
      );

      for (final type in ExpressiveSnackBarType.values) {
        await tester.tap(find.text(type.name));
        await tester.pumpAndSettle();
        expect(find.text('Title ${type.name}'), findsOneWidget);
        expect(find.text('Message ${type.name}'), findsOneWidget);
      }

      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(actionTapped, isTrue);
    });

    testWidgets('uses bounded width on wide (desktop/web) screens', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.dark(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showExpressiveSnackBar(
                    context: context,
                    message: 'Desktop SnackBar',
                    type: ExpressiveSnackBarType.success,
                    maxWidth: 400,
                    showCloseIcon: true,
                  );
                },
                child: const Text('Show Desktop'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Desktop'));
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.width, 400);
      expect(snackBar.margin, isNull);
      expect(snackBar.showCloseIcon, isFalse);
      expect(find.bySemanticsLabel('Close'), findsOneWidget);
      expect(find.byType(HugeIcon), findsWidgets);

      await tester.tap(find.bySemanticsLabel('Close'));
      await tester.pumpAndSettle();
      expect(find.text('Desktop SnackBar'), findsNothing);
    });
  });
}
