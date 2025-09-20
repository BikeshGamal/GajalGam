// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:gajalgam/main.dart';

void main() {
  testWidgets('GajalGam app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GajalGamApp());

    // Verify that the splash screen loads with app title.
    expect(find.text('GajalGam'), findsOneWidget);
    expect(find.text('गजलगम'), findsOneWidget);

    // Wait for splash screen animation and navigation
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Verify that we navigated to the cover page with Start Reading button.
    expect(find.text('Start Reading'), findsOneWidget);
  });
}
