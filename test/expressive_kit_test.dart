import 'package:expressive_kit/expressive_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('ExpressiveButton renders label correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExpressiveButton(label: 'Test Button', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
  });

  testWidgets('ExpressiveLinearProgressIndicator renders without error', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ExpressiveLinearProgressIndicator()),
      ),
    );

    expect(find.byType(ExpressiveLinearProgressIndicator), findsOneWidget);
  });
}
