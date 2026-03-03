import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/get_forecast.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final GetCurrentWeather getCurrentWeather;
  final GetForecast getForecast;

  WeatherProvider({
    required this.getCurrentWeather,
    required this.getForecast,
  });

  WeatherStatus _status = WeatherStatus.initial;
  WeatherEntity? _weather;
  List<ForecastDayEntity> _forecast = [];
  String _errorMessage = '';
  String _currentCity = AppConstants.defaultCity;

  // ── Getters ──────────────────────────────────────────
  WeatherStatus get status => _status;
  WeatherEntity? get weather => _weather;
  List<ForecastDayEntity> get forecast => _forecast;
  String get errorMessage => _errorMessage;
  String get currentCity => _currentCity;

  // ── Load weather on startup ───────────────────────────
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCity = prefs.getString(AppConstants.lastCityKey);
    await fetchWeather(savedCity ?? AppConstants.defaultCity);
  }

  // ── Fetch current weather + forecast ─────────────────
  Future<void> fetchWeather(String city) async {
    _status = WeatherStatus.loading;
    _errorMessage = '';
    notifyListeners();

    final weatherResult = await getCurrentWeather(city);
    final forecastResult = await getForecast(city);

    weatherResult.fold(
      (failure) {
        _status = WeatherStatus.error;
        _errorMessage = failure.message;
      },
      (weather) {
        _weather = weather;
        _currentCity = city;
        _saveLastCity(city);
      },
    );

    forecastResult.fold(
      (_) {}, // silently fail — forecast is secondary
      (forecast) => _forecast = forecast,
    );

    if (_status != WeatherStatus.error) {
      _status = WeatherStatus.loaded;
    }

    notifyListeners();
  }

  Future<void> _saveLastCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.lastCityKey, city);
  }

  void refresh() => fetchWeather(_currentCity);
}
