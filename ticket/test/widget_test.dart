import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticket/authentication_screen.dart';

void main() {
  testWidgets('Authentication screen renders', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AuthenticationScreen(), // Render AuthenticationScreen
    ));

    // Verify that the authentication screen renders.
    expect(find.text('Welcome to Train E-Ticket'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Don\'t have an account?'), findsOneWidget);
  });

  // Add more tests for other screens and functionality as needed
}
