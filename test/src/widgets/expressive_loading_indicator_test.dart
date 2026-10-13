import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveLinearProgressIndicator', () {
    testWidgets('renders determinate at various progress milestones', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const ExpressiveLinearProgressIndicator(value: -0.1),
                  const ExpressiveLinearProgressIndicator(value: 0.0),
                  const ExpressiveLinearProgressIndicator(
                    value: 0.001,
                    width: 300,
                    color: Colors.purple,
                    backgroundColor: Colors.grey,
                    stopDotColor: Colors.purpleAccent,
                  ),
                  const ExpressiveLinearProgressIndicator(
                    value: 0.4,
                    width: 300,
                  ),
                  const ExpressiveLinearProgressIndicator(
                    value: 0.88,
                    width: 300,
                  ),
                  const ExpressiveLinearProgressIndicator(
                    value: 0.96,
                    width: 300,
                  ),
                  const ExpressiveLinearProgressIndicator(
                    value: 1.0,
                    width: 300,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  const ExpressiveLinearProgressIndicator(value: 1.5),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ExpressiveLinearProgressIndicator), findsNWidgets(8));
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('renders indeterminate across all animation phases', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpressiveLinearProgressIndicator(
              width: 300,
              height: 20,
              strokeWidth: 5,
              wavelength: 24,
              amplitude: 4,
            ),
          ),
        ),
      );

      expect(find.byType(ExpressiveLinearProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump(const Duration(milliseconds: 800));
      await tester.pump(const Duration(milliseconds: 1200));
      await tester.pump(const Duration(milliseconds: 1600));
      await tester.pump(const Duration(milliseconds: 2000));
    });

    testWidgets('switches between determinate and indeterminate dynamically', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ExpressiveLinearProgressIndicator(value: null)),
        ),
      );

      await tester.pump(const Duration(milliseconds: 200));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ExpressiveLinearProgressIndicator(value: 0.7)),
        ),
      );

      await tester.pumpAndSettle();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ExpressiveLinearProgressIndicator(value: null)),
        ),
      );

      await tester.pump(const Duration(milliseconds: 200));
    });

    testWidgets('handles small width without crashing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 4,
              child: ExpressiveLinearProgressIndicator(value: 0.5),
            ),
          ),
        ),
      );

      expect(find.byType(ExpressiveLinearProgressIndicator), findsOneWidget);
    });
  });

  group('ExpressiveCircularProgressIndicator', () {
    testWidgets('renders determinate at various progress milestones', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const ExpressiveCircularProgressIndicator(value: -0.1),
                  const ExpressiveCircularProgressIndicator(value: 0.0),
                  const ExpressiveCircularProgressIndicator(
                    value: 0.005,
                    color: Colors.blue,
                    backgroundColor: Colors.black12,
                    stopDotColor: Colors.blueAccent,
                  ),
                  const ExpressiveCircularProgressIndicator(value: 0.5),
                  const ExpressiveCircularProgressIndicator(value: 0.89),
                  const ExpressiveCircularProgressIndicator(value: 0.97),
                  const ExpressiveCircularProgressIndicator(
                    value: 1.0,
                    size: 60,
                    strokeWidth: 6,
                    waveCount: 10,
                    amplitude: 3,
                  ),
                  const ExpressiveCircularProgressIndicator(value: 1.2),
                ],
              ),
            ),
          ),
        ),
      );

      expect(
        find.byType(ExpressiveCircularProgressIndicator),
        findsNWidgets(8),
      );
    });

    testWidgets('renders indeterminate across all animation phases', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ExpressiveCircularProgressIndicator()),
        ),
      );

      expect(find.byType(ExpressiveCircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump(const Duration(milliseconds: 1000));
      await tester.pump(const Duration(milliseconds: 1400));
      await tester.pump(const Duration(milliseconds: 1800));
      await tester.pump(const Duration(milliseconds: 2000));
    });

    testWidgets('switches between determinate and indeterminate dynamically', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpressiveCircularProgressIndicator(value: null),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 200));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ExpressiveCircularProgressIndicator(value: 0.4)),
        ),
      );

      await tester.pumpAndSettle();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpressiveCircularProgressIndicator(value: null),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 200));
    });

    testWidgets('handles small size without crashing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpressiveCircularProgressIndicator(size: 2, value: 0.5),
          ),
        ),
      );

      expect(find.byType(ExpressiveCircularProgressIndicator), findsOneWidget);
    });

    testWidgets('instantiates non-const ExpressiveCircularProgressIndicator', (
      tester,
    ) async {
      final progress = 0.5;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveCircularProgressIndicator(value: progress),
          ),
        ),
      );

      expect(find.byType(ExpressiveCircularProgressIndicator), findsOneWidget);
    });
  });
}
