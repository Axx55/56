import 'package:flutter_test/flutter_test.dart';
import 'package:masarat_transport_app/main.dart';

void main() {
  testWidgets('App loads without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const MasaratApp());
    expect(find.byType(MasaratApp), findsOneWidget);
  });
}
