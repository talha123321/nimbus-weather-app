import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, WeatherEntity>> call(String city) {
    return repository.getCurrentWeather(city);
  }
}
