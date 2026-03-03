import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/weather_entity.dart';
import '../entities/forecast_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);
  Future<Either<Failure, List<ForecastDayEntity>>> getForecast(String city);
}
