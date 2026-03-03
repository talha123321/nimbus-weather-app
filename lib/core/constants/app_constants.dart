import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String get apiKey => dotenv.env['WEATHER_API_KEY'] ?? '';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String defaultCity = 'London';
  static const String lastCityKey = 'last_city';
}
