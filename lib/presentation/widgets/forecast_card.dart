import 'package:flutter/material.dart';
import '../../domain/entities/forecast_entity.dart';

class ForecastCard extends StatelessWidget {
  final ForecastDayEntity forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E2A3A)
            : const Color(0xFF4A90D9).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white12
              : const Color(0xFF4A90D9).withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            _dayName(forecast.date),
            style: TextStyle(
              color: isDark ? Colors.white70 : const Color(0xFF555588),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Image.network(
            'https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png',
            width: 45,
            height: 45,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.cloud, size: 35, color: Colors.blueGrey),
          ),
          const SizedBox(height: 8),
          Text(
            '${forecast.tempMax.round()}°',
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A2E),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${forecast.tempMin.round()}°',
            style: TextStyle(
              color: isDark ? Colors.white54 : const Color(0xFF8888AA),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  String _dayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}
