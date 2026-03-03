import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/failures.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String city);
  Future<List<ForecastDayModel>> getForecast(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl({required this.dio});

  @override
  Future<WeatherModel> getCurrentWeather(String city) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}/weather',
        queryParameters: {
          'q': city,
          'appid': AppConstants.apiKey,
          'units': 'metric',
        },
      );
      return WeatherModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? e.message ?? 'Unknown error';
      throw ServerFailure(message: msg.toString());
    }
  }

  @override
  Future<List<ForecastDayModel>> getForecast(String city) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}/forecast/daily',
        queryParameters: {
          'q': city,
          'appid': AppConstants.apiKey,
          'units': 'metric',
          'cnt': 7,
        },
      );
      final list = response.data['list'] as List<dynamic>;
      return list
          .map(
              (item) => ForecastDayModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? e.message ?? 'Unknown error';
      throw ServerFailure(message: msg.toString());
    }
  }
}
