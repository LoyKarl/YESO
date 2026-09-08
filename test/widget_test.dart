import 'package:flutter_test/flutter_test.dart';
import 'package:yeso/main.dart';

void main() {
  testWidgets('YESO app loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const YESOApp());
    expect(find.text('YES-O'), findsWidgets);
  });
}
