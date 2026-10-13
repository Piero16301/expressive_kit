import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpressiveCarousel', () {
    testWidgets('renders items with and without onTap', (tester) async {
      var itemTapped = false;
      final items = [
        ExpressiveCarouselItem(
          child: const Text('Tappable Item'),
          onTap: () => itemTapped = true,
        ),
        const ExpressiveCarouselItem(child: Text('Non-tappable Item')),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpressiveCarousel(
              items: items,
              itemExtent: 200,
              height: 160,
              spacing: 16,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      );

      expect(find.text('Tappable Item'), findsOneWidget);
      expect(find.text('Non-tappable Item'), findsOneWidget);

      await tester.tap(find.text('Tappable Item'));
      await tester.pumpAndSettle();

      expect(itemTapped, isTrue);
    });
  });
}
