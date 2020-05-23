// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:condor_sports_flutter/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFFFDCD07),
            primaryColorDark: Color(0xFFC59D00),
            accentColor: Color(0xFF393536)),
        home: Scaffold(
          body: LoadingWidget(),
        ),
      ),
    );

    await expectLater(
        find.byType(LoadingWidget), matchesGoldenFile("goldens/loading.png"));
  });
}
