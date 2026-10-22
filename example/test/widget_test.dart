import 'package:flutter_test/flutter_test.dart';
import 'package:newlandscanner_example/main.dart';

void main() {
  testWidgets('Renders waiting state on initial load', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Plugin example app'), findsOneWidget);
    expect(find.text('Waiting for Data'), findsOneWidget);
  });
}
