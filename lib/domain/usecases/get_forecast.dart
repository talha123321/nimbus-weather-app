import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/forecast_entity.dart';
import '../repositories/weather_repository.dart';

class GetForecast {
  final WeatherRepository repository;

  GetForecast(this.repository);

  Future<Either<Failure, List<ForecastDayEntity>>> call(String city) {
    return repository.getForecast(city);
  }
}
