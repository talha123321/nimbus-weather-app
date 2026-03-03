import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/weather_remote_datasource.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_current_weather.dart';
import 'domain/usecases/get_forecast.dart';
import 'presentation/providers/weather_provider.dart';
import 'presentation/providers/theme_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ── Providers ─────────────────────────────────────────
  sl.registerFactory(() => WeatherProvider(
        getCurrentWeather: sl(),
        getForecast: sl(),
      ));
  sl.registerLazySingleton(() => ThemeProvider());

  // ── Use Cases ─────────────────────────────────────────
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => GetForecast(sl()));

  // ── Repository ────────────────────────────────────────
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl()),
  );

  // ── Data Sources ──────────────────────────────────────
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(dio: sl()),
  );

  // ── External ──────────────────────────────────────────
  sl.registerLazySingleton(() => Dio());
}
