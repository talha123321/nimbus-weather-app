import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_card.dart';
import '../widgets/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showSearch(BuildContext context) {
    final weatherProvider = context.read<WeatherProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SearchBarWidget(
        onSearch: (city) => weatherProvider.fetchWeather(city),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('☁️ Weather'),
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search city',
            onPressed: () => _showSearch(context),
          ),
          // Theme toggle
          Consumer<ThemeProvider>(
            builder: (_, themeProvider, __) => IconButton(
              icon: Icon(
                themeProvider.isDarkMode
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
              ),
              tooltip: 'Toggle theme',
              onPressed: themeProvider.toggleTheme,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, _) {
          return switch (provider.status) {
            WeatherStatus.initial || WeatherStatus.loading => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Fetching weather...'),
                  ],
                ),
              ),
            WeatherStatus.error => _ErrorState(
                message: provider.errorMessage,
                onRetry: provider.refresh,
              ),
            WeatherStatus.loaded => _LoadedState(provider: provider),
          };
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSearch(context),
        icon: const Icon(Icons.search),
        label: const Text('Search City'),
      ),
    );
  }
}

// ── Loaded State ────────────────────────────────────────
class _LoadedState extends StatelessWidget {
  final WeatherProvider provider;
  const _LoadedState({required this.provider});

  @override
  Widget build(BuildContext context) {
    final weather = provider.weather!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subtleColor =
        isDark ? const Color(0xFF9999CC) : const Color(0xFF555588);

    return RefreshIndicator(
      onRefresh: () async => provider.refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // ── Main Weather Card ──────────────────────
            WeatherCard(weather: weather),

            const SizedBox(height: 28),

            // ── Forecast Section ───────────────────────
            if (provider.forecast.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '7-Day Forecast',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16),
                  itemCount: provider.forecast.length,
                  itemBuilder: (_, i) =>
                      ForecastCard(forecast: provider.forecast[i]),
                ),
              ),
              const SizedBox(height: 28),
            ],

            // ── Sun Times ─────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Sun Schedule',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _SunCard(
                      icon: Icons.wb_sunny_rounded,
                      label: 'Sunrise',
                      time: _formatTime(weather.sunrise),
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SunCard(
                      icon: Icons.nights_stay_rounded,
                      label: 'Sunset',
                      time: _formatTime(weather.sunset),
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Last Updated ──────────────────────────
            Center(
              child: Text(
                'Updated ${_formatTime(weather.lastUpdated)}  •  Pull to refresh',
                style: TextStyle(color: subtleColor, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}

// ── Sun Card ────────────────────────────────────────────
class _SunCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;
  final Color color;

  const _SunCard({
    required this.icon,
    required this.label,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2A3A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      color: isDark ? Colors.white54 : Colors.black54,
                      fontSize: 13)),
              Text(time,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Error State ─────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 72, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
