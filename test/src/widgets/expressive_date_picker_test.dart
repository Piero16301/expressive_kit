import 'package:expressive_kit/expressive_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveDatePicker', () {
    testWidgets(
      'day mode selects a day, navigates months, and returns DateTime',
      (tester) async {
        DateTime? picked;

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    picked = await ExpressiveDatePicker.showDayPicker(
                      context: context,
                      initialDate: DateTime(2026, 5, 10),
                      firstDate: DateTime(2026, 5, 5),
                      lastDate: DateTime(2026, 6, 20),
                      confirmLabel: 'Confirm',
                      cancelLabel: 'Cancel',
                    );
                  },
                  child: const Text('Open Day'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open Day'));
        await tester.pumpAndSettle();

        expect(find.text('Select date'), findsOneWidget);

        // Disabled day before firstDate (May 2) should not select
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();

        // Navigate to next month (June) and back to May
        await tester.tap(
          find.byWidgetPredicate(
            (w) =>
                w is HugeIcon && w.icon == HugeIcons.strokeRoundedArrowRight01,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byWidgetPredicate(
            (w) =>
                w is HugeIcon && w.icon == HugeIcons.strokeRoundedArrowLeft01,
          ),
        );
        await tester.pumpAndSettle();

        // Select day 15
        await tester.tap(find.text('15'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle();

        expect(picked, DateTime(2026, 5, 15));
      },
    );

    testWidgets('month mode selects a single month and returns DateTime', (
      tester,
    ) async {
      DateTime? picked;

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  picked = await ExpressiveDatePicker.showMonthPicker(
                    context: context,
                    initialDate: DateTime(2026, 3),
                    firstDate: DateTime(2026, 2),
                    lastDate: DateTime(2026, 11),
                    confirmLabel: 'Select',
                  );
                },
                child: const Text('Open Month'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Month'));
      await tester.pumpAndSettle();

      expect(find.text('Select month'), findsOneWidget);
      expect(find.text('2026'), findsOneWidget);

      // Disabled month before firstDate (Jan)
      await tester.tap(find.text('Jan'));
      await tester.pumpAndSettle();

      // Select Aug
      await tester.tap(find.text('Aug'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(picked, DateTime(2026, 8));
    });

    testWidgets('monthRange mode selects range including reversed tap order', (
      tester,
    ) async {
      DateTimeRange? range;

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.dark(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  range = await ExpressiveDatePicker.showMonthRangePicker(
                    context: context,
                    confirmLabel: 'Apply',
                  );
                },
                child: const Text('Open MonthRange'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open MonthRange'));
      await tester.pumpAndSettle();

      expect(find.text('Select month range'), findsOneWidget);

      // Tap Jun then Feb -> should swap so start=Feb, end=Jun
      await tester.tap(find.text('Jun'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Feb'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      expect(range, isNotNull);
      expect(range!.start.month, 2);
      expect(range!.end.month, 6);
    });

    testWidgets(
      'yearRange mode selects year range and navigates 12-year pages',
      (tester) async {
        DateTimeRange? range;

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    range = await ExpressiveDatePicker.showYearRangePicker(
                      context: context,
                      initialStartDate: DateTime(2025),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      confirmLabel: 'OK',
                    );
                  },
                  child: const Text('Open YearRange'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open YearRange'));
        await tester.pumpAndSettle();

        expect(find.text('Select year range'), findsOneWidget);
        expect(find.text('2016 - 2027'), findsOneWidget);

        await tester.tap(
          find.byWidgetPredicate(
            (w) =>
                w is HugeIcon && w.icon == HugeIcons.strokeRoundedArrowRight01,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('2028 - 2039'), findsOneWidget);

        await tester.tap(find.text('2028'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        expect(range, isNotNull);
        expect(range!.start.year, 2025);
        expect(range!.end.year, 2028);
      },
    );

    testWidgets(
      'day mode handles null initialDate, fallback locale, and cancel',
      (tester) async {
        DateTime? picked = DateTime(2000);

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    picked = await ExpressiveDatePicker.showDayPicker(
                      context: context,
                      locale: const Locale('zz'),
                      cancelLabel: 'Dismiss',
                    );
                  },
                  child: const Text('Open Null Day'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open Null Day'));
        await tester.pumpAndSettle();

        expect(find.text('Choose a day'), findsOneWidget);

        await tester.tap(find.text('Dismiss'));
        await tester.pumpAndSettle();

        expect(picked, isNull);
      },
    );

    testWidgets('monthRange navigates years and formats cross-year selection', (
      tester,
    ) async {
      DateTimeRange? range;

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  range = await ExpressiveDatePicker.showMonthRangePicker(
                    context: context,
                    confirmLabel: 'Apply',
                  );
                },
                child: const Text('Open CrossYear'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open CrossYear'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Nov'));
      await tester.pumpAndSettle();

      await tester.tap(
        find.byWidgetPredicate(
          (w) => w is HugeIcon && w.icon == HugeIcons.strokeRoundedArrowRight01,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Feb'));
      await tester.pumpAndSettle();

      await tester.tap(
        find.byWidgetPredicate(
          (w) => w is HugeIcon && w.icon == HugeIcons.strokeRoundedArrowLeft01,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      expect(range, isNotNull);
      expect(range!.start.month, 11);
      expect(range!.end.month, 2);
      expect(range!.end.year, range!.start.year + 1);
    });

    testWidgets(
      'yearRange handles null initial, previous page, reversed tap and reset',
      (tester) async {
        DateTimeRange? range;

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    range = await ExpressiveDatePicker.showYearRangePicker(
                      context: context,
                      confirmLabel: 'OK',
                    );
                  },
                  child: const Text('Open Null YearRange'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open Null YearRange'));
        await tester.pumpAndSettle();

        expect(find.text('Choose years'), findsOneWidget);

        await tester.tap(
          find.byWidgetPredicate(
            (w) =>
                w is HugeIcon && w.icon == HugeIcons.strokeRoundedArrowLeft01,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byWidgetPredicate(
            (w) =>
                w is HugeIcon && w.icon == HugeIcons.strokeRoundedArrowRight01,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('2025'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('2022'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('2024'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        expect(range, isNotNull);
        expect(range!.start.year, 2024);
      },
    );
  });
}
