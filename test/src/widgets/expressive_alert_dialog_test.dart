import 'package:expressive_kit/expressive_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveAlertDialog', () {
    testWidgets('renders title, content, icon badge and handles callbacks', (
      tester,
    ) async {
      var confirmed = false;
      var cancelled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: ExpressiveAlertDialog(
              title: 'Confirm Action',
              content: 'Are you sure you want to continue?',
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedInformationCircle,
              ),
              confirmLabel: 'Yes',
              cancelLabel: 'No',
              onConfirm: () => confirmed = true,
              onCancel: () => cancelled = true,
            ),
          ),
        ),
      );

      expect(find.text('Confirm Action'), findsOneWidget);
      expect(find.text('Are you sure you want to continue?'), findsOneWidget);
      expect(find.byType(ExpressiveBadge), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);

      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();
      expect(confirmed, isTrue);

      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();
      expect(cancelled, isTrue);
    });

    testWidgets(
      'supports isForm, isDestructive, single button and custom child',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.dark(),
            home: Scaffold(
              body: ExpressiveAlertDialog(
                title: 'Delete Workspace',
                isForm: true,
                isDestructive: true,
                showCancelButton: false,
                icon: const HugeIcon(icon: HugeIcons.strokeRoundedCancel01),
                confirmLabel: 'Delete',
                child: ExpressiveTextFormField.filled(
                  labelText: 'Confirmation',
                ),
                onConfirm: () {},
              ),
            ),
          ),
        );

        expect(find.text('Delete Workspace'), findsOneWidget);
        expect(find.byType(ExpressiveTextFormField), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
        expect(find.byType(ExpressiveButton), findsOneWidget);
      },
    );

    testWidgets('showExpressiveAlertDialog opens dialog and returns bool', (
      tester,
    ) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await showExpressiveAlertDialog<bool>(
                    context: context,
                    title: 'Quick Prompt',
                    content: 'Proceed?',
                    confirmLabel: 'Proceed',
                    cancelLabel: 'Abort',
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Quick Prompt'), findsOneWidget);

      await tester.tap(find.text('Proceed'));
      await tester.pumpAndSettle();
      expect(result, isTrue);

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Abort'));
      await tester.pumpAndSettle();
      expect(result, isFalse);
    });
  });
}
