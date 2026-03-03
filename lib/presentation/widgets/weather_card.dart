import 'package:flutter/material.dart';
import '../../domain/entities/weather_entity.dart';
import 'weather_info_tile.dart';

class WeatherCard extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    final subColor = isDark ? Colors.white70 : const Color(0xFF555588);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E3A5F), const Color(0xFF0D1B2A)]
              : [const Color(0xFF4A90D9), const Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90D9).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // City & Country
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.cityName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    weather.country,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
              // Weather Icon from OpenWeatherMap
              Image.network(
                'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                width: 80,
                height: 80,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.cloud, size: 60, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Big Temperature
          Text(
            '${weather.temperature.round()}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 72,
              fontWeight: FontWeight.w300,
              height: 1,
            ),
          ),
          Text(
            _capitalize(weather.description),
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),

          const SizedBox(height: 8),

          // Min / Max / Feels Like
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('↑ ${weather.tempMax.round()}°',
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
              const SizedBox(width: 12),
              Text('↓ ${weather.tempMin.round()}°',
                  style: const TextStyle(color: Colors.white70, fontSize: 15)),
              const SizedBox(width: 12),
              Text('Feels ${weather.feelsLike.round()}°',
                  style: const TextStyle(color: Colors.white70, fontSize: 15)),
            ],
          ),

          const SizedBox(height: 20),
          const Divider(color: Colors.white24),
          const SizedBox(height: 12),

          // Info Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherInfoTile(
                icon: Icons.water_drop_outlined,
                label: 'Humidity',
                value: '${weather.humidity}%',
              ),
              WeatherInfoTile(
                icon: Icons.air,
                label: 'Wind',
                value: '${weather.windSpeed.round()} m/s',
              ),
              WeatherInfoTile(
                icon: Icons.compress,
                label: 'Pressure',
                value: '${weather.pressure} hPa',
              ),
              WeatherInfoTile(
                icon: Icons.visibility_outlined,
                label: 'Visibility',
                value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
