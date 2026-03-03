import '../../domain/entities/forecast_entity.dart';

class ForecastDayModel extends ForecastDayEntity {
  const ForecastDayModel({
    required super.date,
    required super.tempMin,
    required super.tempMax,
    required super.description,
    required super.iconCode,
    required super.humidity,
    required super.windSpeed,
  });

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      date: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
      tempMin: (json['temp']['min'] as num).toDouble(),
      tempMax: (json['temp']['max'] as num).toDouble(),
      description: json['weather'][0]['description'] as String,
      iconCode: json['weather'][0]['icon'] as String,
      humidity: json['humidity'] as int,
      windSpeed: (json['speed'] as num).toDouble(),
    );
  }
}
