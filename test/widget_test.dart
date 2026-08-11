import 'package:flutter_test/flutter_test.dart';
import 'package:inisurat/main.dart';

void main() {
  testWidgets('app starts and shows login screen', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Pembuat Surat Otomatis'), findsOneWidget);
  });
}