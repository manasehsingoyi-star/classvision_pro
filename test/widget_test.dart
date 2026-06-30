import 'package:flutter_test/flutter_test.dart';
import 'package:classvision_pro/main.dart';

void main() {
  testWidgets('App opens', (WidgetTester tester) async {
    await tester.pumpWidget(const ClassVisionApp());
    expect(find.text('ClassVision Pro'), findsOneWidget);
  });
}
