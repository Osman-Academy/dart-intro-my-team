// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:task_manager_clean_arch/main.dart';

void main() {
  testWidgets('App shows title and Add user sheet opens',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Check app title
    expect(find.text('Team Manager'), findsOneWidget);

    // FAB present
    final fab = find.byIcon(Icons.person_add);
    expect(fab, findsOneWidget);

    // Tap FAB and expect Add user sheet to appear (check for form label)
    await tester.tap(fab);
    await tester.pumpAndSettle();

    expect(find.text('Full name'), findsOneWidget);
  });
}
