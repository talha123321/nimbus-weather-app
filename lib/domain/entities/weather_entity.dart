import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;
  final String description;
  final String iconCode;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime lastUpdated;

  const WeatherEntity({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    required this.description,
    required this.iconCode,
    required this.sunrise,
    required this.sunset,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [cityName, country, temperature, lastUpdated];
}
