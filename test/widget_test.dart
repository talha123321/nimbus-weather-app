import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';

void main() {
  testWidgets('WeatherApp launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const WeatherApp());
    expect(find.byType(WeatherApp), findsOneWidget);
  });
}
