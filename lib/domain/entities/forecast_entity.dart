import 'package:equatable/equatable.dart';

class ForecastDayEntity extends Equatable {
  final DateTime date;
  final double tempMin;
  final double tempMax;
  final String description;
  final String iconCode;
  final int humidity;
  final double windSpeed;

  const ForecastDayEntity({
    required this.date,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [date, tempMin, tempMax];
}
