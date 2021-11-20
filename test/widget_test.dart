// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssflow/main.dart';
import 'package:ssflow/pages/home_page/home_page.dart';

void main() {
  testWidgets('Rendering draggable objects test', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: SSFlow()));

    expect(find.byType(HomePage), findsOneWidget);
  });
}
