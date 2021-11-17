// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:ssflow/main.dart';
import 'package:ssflow/models/draggable_objects/_draggable_objects.dart';

void main() {
  testWidgets('Rendering draggable objects test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SSFlow());

    // finds all draggable widgets
    expect(find.byType(SSDraggableColumn), findsOneWidget);
    expect(find.byType(SSDraggableFunction), findsOneWidget);
    expect(find.byType(SSDraggableRepeatHorizontal), findsOneWidget);
    expect(find.byType(SSDraggableRepeatVertical), findsOneWidget);
    expect(find.byType(SSDraggableRow), findsOneWidget);
    expect(find.byType(SSDraggableTableData), findsOneWidget);
    expect(find.byType(SSDraggableBlock), findsOneWidget);
  });
}
