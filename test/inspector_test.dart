import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspector/inspector.dart';

void main() {
  testWidgets('Inspector renders without crashing', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Inspector(
          child: Scaffold(
            body: Container(
              color: Colors.blue,
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );

    // Just verify it renders
    expect(find.byType(Inspector), findsOneWidget);
  });
}
