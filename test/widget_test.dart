// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:ssflow/main.dart';
import 'package:ssflow/pages/home_page/home_page.dart';

void main() {
  testWidgets('Rendering draggable objects test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: SSFlow()),
    );

    expect(find.byType(HomePage), findsOneWidget);
  });
}
