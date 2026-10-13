import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Expressive Kit Gallery smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Expressive Kit Gallery'), findsOneWidget);
    expect(find.text('Controls'), findsOneWidget);
    expect(find.text('Content'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('Navigation'), findsOneWidget);
  });
}
