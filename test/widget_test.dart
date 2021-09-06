// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:ssflow/main.dart';
import 'package:ssflow/pages/home_page/left_side_area/widget_area/_widget_area.dart';

void main() {
  testWidgets('Rendering draggable objects test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SSFlow());

    // finds all draggable widgets
    expect(find.byType(ColumnWidget), findsOneWidget);
    expect(find.byType(FunctionWidget), findsOneWidget);
    expect(find.byType(RepeatHorizontalWidget), findsOneWidget);
    expect(find.byType(RepeatVerticalWidget), findsOneWidget);
    expect(find.byType(RowWidget), findsOneWidget);
    expect(find.byType(TableDataWidget), findsOneWidget);
    expect(find.byType(BlockWidget), findsOneWidget);
  });
}
