import 'package:expressive_kit/expressive_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ExpressiveTextFormField', () {
    testWidgets('renders label, hint, helper, prefix and suffix icons', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: ExpressiveTextFormField(
              labelText: 'Email',
              hintText: 'you@example.com',
              helperText: 'We will never share your email',
              prefixIcon: const HugeIcon(icon: HugeIcons.strokeRoundedMail01),
              suffixIcon: const HugeIcon(icon: HugeIcons.strokeRoundedTick01),
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('you@example.com'), findsOneWidget);
      expect(find.text('We will never share your email'), findsOneWidget);
      expect(find.byType(HugeIcon), findsNWidgets(2));
    });

    testWidgets('supports filled, outlined and tonal named constructors', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: Column(
              children: [
                ExpressiveTextFormField.filled(labelText: 'Filled'),
                ExpressiveTextFormField.outlined(labelText: 'Outlined'),
                ExpressiveTextFormField.tonal(labelText: 'Tonal'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Filled'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
      expect(find.text('Tonal'), findsOneWidget);
    });

    testWidgets(
      'handles text input, callbacks, Form validation, save and reset',
      (tester) async {
        final formKey = GlobalKey<FormState>();
        String? changedValue;
        String? submittedValue;
        String? savedValue;

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: Form(
                key: formKey,
                child: ExpressiveTextFormField(
                  initialValue: '',
                  labelText: 'Username',
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  onChanged: (val) => changedValue = val,
                  onFieldSubmitted: (val) => submittedValue = val,
                  onSaved: (val) => savedValue = val,
                ),
              ),
            ),
          ),
        );

        // Invalid when empty
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pumpAndSettle();
        expect(find.text('Username is required'), findsOneWidget);

        // Enter valid text
        await tester.enterText(find.byType(TextField), 'expressive_user');
        await tester.pumpAndSettle();
        expect(changedValue, 'expressive_user');

        await tester.testTextInput.receiveAction(TextInputAction.done);
        expect(submittedValue, 'expressive_user');

        // Now valid and savable
        expect(formKey.currentState!.validate(), isTrue);
        await tester.pumpAndSettle();
        expect(find.text('Username is required'), findsNothing);

        formKey.currentState!.save();
        expect(savedValue, 'expressive_user');

        // Reset clears back to initialValue
        formKey.currentState!.reset();
        await tester.pumpAndSettle();
        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller!.text, '');
      },
    );

    testWidgets('showClearButton clears text and invokes onChanged', (
      tester,
    ) async {
      final controller = TextEditingController(text: 'Initial');
      addTearDown(controller.dispose);
      String? lastChanged;

      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: ExpressiveTextFormField(
              controller: controller,
              labelText: 'Searchable',
              showClearButton: true,
              onChanged: (val) => lastChanged = val,
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('Clear text'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Clear text'));
      await tester.pumpAndSettle();

      expect(controller.text, isEmpty);
      expect(lastChanged, '');
      expect(find.bySemanticsLabel('Clear text'), findsNothing);
    });

    testWidgets('showPasswordToggle toggles obscureText state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: ExpressiveTextFormField(
              labelText: 'Password',
              obscureText: true,
              showPasswordToggle: true,
            ),
          ),
        ),
      );

      TextField textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Show password'));
      await tester.pumpAndSettle();

      textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isFalse);
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
    });

    testWidgets('renders character counter when maxLength is set', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.light(),
          home: Scaffold(
            body: ExpressiveTextFormField(
              labelText: 'Bio',
              maxLength: 50,
              maxLines: 3,
            ),
          ),
        ),
      );

      expect(find.text('0/50'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Hello');
      await tester.pumpAndSettle();

      expect(find.text('5/50'), findsOneWidget);
    });

    testWidgets('respects disabled state and custom colors/radius', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ExpressiveTheme.dark(),
          home: Scaffold(
            body: ExpressiveTextFormField(
              initialValue: 'Locked',
              enabled: false,
              showClearButton: true,
              borderRadius: BorderRadius.circular(16),
              backgroundColor: Colors.grey.shade900,
              borderColor: Colors.grey.shade700,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
      expect(find.bySemanticsLabel('Clear text'), findsNothing);
    });

    testWidgets(
      'handles didUpdateWidget controller, focusNode, and obscureText transitions',
      (tester) async {
        final externalController = TextEditingController(text: 'External');
        final externalController2 = TextEditingController(text: 'Initial');
        final externalFocusNode = FocusNode();
        addTearDown(externalController.dispose);
        addTearDown(externalController2.dispose);
        addTearDown(externalFocusNode.dispose);

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: ExpressiveTextFormField(
                initialValue: 'Initial',
                labelText: 'Dynamic',
                obscureText: false,
              ),
            ),
          ),
        );

        expect(find.text('Initial'), findsOneWidget);

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: ExpressiveTextFormField(
                controller: externalController,
                focusNode: externalFocusNode,
                labelText: 'Dynamic',
                obscureText: true,
              ),
            ),
          ),
        );

        TextField textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller, externalController);
        expect(textField.focusNode, externalFocusNode);
        expect(textField.obscureText, isTrue);

        await tester.enterText(find.byType(TextField), 'Typed');
        await tester.pump();

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: ExpressiveTextFormField(
                controller: externalController2,
                focusNode: externalFocusNode,
                labelText: 'Dynamic',
                obscureText: true,
              ),
            ),
          ),
        );

        textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller, externalController2);
        expect(textField.controller!.text, 'Initial');

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: ExpressiveTextFormField(
                labelText: 'Dynamic',
                obscureText: false,
              ),
            ),
          ),
        );

        textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller, isNot(externalController2));
        expect(textField.controller!.text, 'Initial');
        expect(textField.focusNode, isNot(externalFocusNode));
        expect(textField.obscureText, isFalse);
      },
    );

    testWidgets(
      'renders disabled and error states for outlined and tonal variants',
      (tester) async {
        final tonalFocus = FocusNode();
        addTearDown(tonalFocus.dispose);

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: Column(
                children: [
                  ExpressiveTextFormField.outlined(
                    labelText: 'Outlined Disabled',
                    enabled: false,
                  ),
                  ExpressiveTextFormField.tonal(
                    labelText: 'Tonal Disabled',
                    enabled: false,
                  ),
                  ExpressiveTextFormField.tonal(
                    labelText: 'Tonal Error',
                    errorText: 'Tonal error',
                    focusNode: tonalFocus,
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Tonal error'), findsOneWidget);

        tonalFocus.requestFocus();
        await tester.pumpAndSettle();
        expect(tonalFocus.hasFocus, isTrue);
      },
    );

    testWidgets(
      'tapping container prefixIcon requests focus and invokes onTap',
      (tester) async {
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);
        var tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            theme: ExpressiveTheme.light(),
            home: Scaffold(
              body: ExpressiveTextFormField(
                focusNode: focusNode,
                labelText: 'With Prefix',
                prefixIcon: const HugeIcon(icon: HugeIcons.strokeRoundedMail01),
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        expect(focusNode.hasFocus, isFalse);

        await tester.tap(find.byType(HugeIcon));
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);
        expect(tapped, isTrue);
      },
    );
  });
}
