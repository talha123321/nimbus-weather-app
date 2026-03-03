# 🌤️ Nimbus — Weather App

A production-grade Flutter weather application built to demonstrate clean architecture, state management, and modern Flutter development practices.


## ✨ Features

- 🌍 Search any city worldwide
- 🌗 Dark / Light theme toggle
- 🔄 Pull-to-refresh
- 💾 Last searched city remembered on relaunch
- 🌡️ Temperature, humidity, wind speed, pressure & visibility
- 🌅 Sunrise & sunset times

---

## 🏗️ Architecture

Built with **Clean Architecture** — strictly separated into 3 layers:
```
lib/
├── core/                   # Constants, errors, theme
├── data/                   # Models, API datasources, repository implementations
├── domain/                 # Entities, use cases, repository contracts
└── presentation/           # Providers, pages, widgets
```

### Why Clean Architecture?
- Each layer has one responsibility
- Business logic is completely independent of UI
- Easy to test, maintain and scale
- Swapping the API or state management doesn't break anything

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter** | UI framework |
| **Provider** | State management |
| **Dio** | HTTP client for API calls |
| **GetIt** | Dependency injection / service locator |
| **Dartz** | Functional error handling (`Either<Failure, T>`) |
| **SharedPreferences** | Local storage (theme + last city) |
| **Equatable** | Value equality for entities |
| **flutter_dotenv** | Secure API key management |

---

## 🧠 Key Concepts Demonstrated

- ✅ Clean Architecture (Data / Domain / Presentation layers)
- ✅ Use Cases as single-responsibility business logic units
- ✅ Provider (`ChangeNotifier`) state management
- ✅ Dependency Injection with GetIt service locator
- ✅ `Either<Failure, T>` functional error handling
- ✅ Responsive UI (phones + tablets + landscape)
- ✅ Dark / Light theme with persistence
- ✅ Secure API key storage with `.env`

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.5.2`
- Dart SDK `>=3.5.2`
- OpenWeatherMap API key (free at [openweathermap.org](https://openweathermap.org/api))

---

## 📦 Project Structure
```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart        # API base URL, default city
│   ├── errors/
│   │   └── failures.dart             # ServerFailure, CacheFailure
│   └── theme/
│       └── app_theme.dart            # Light & dark themes
│
├── data/
│   ├── datasources/
│   │   └── weather_remote_datasource.dart   # Dio API calls
│   ├── models/
│   │   ├── weather_model.dart               # JSON → WeatherEntity
│   │   └── forecast_model.dart              # JSON → ForecastEntity
│   └── repositories/
│       └── weather_repository_impl.dart     # Implements domain contract
│
├── domain/
│   ├── entities/
│   │   ├── weather_entity.dart              # Core weather data model
│   │   └── forecast_entity.dart             # Core forecast data model
│   ├── repositories/
│   │   └── weather_repository.dart          # Abstract contract
│   └── usecases/
│       ├── get_current_weather.dart         # Fetch current weather
│       └── get_forecast.dart                # Fetch 7-day forecast
│
├── presentation/
│   ├── providers/
│   │   ├── weather_provider.dart            # Weather state management
│   │   └── theme_provider.dart              # Theme state management
│   ├── pages/
│   │   └── home_page.dart                   # Main screen
│   └── widgets/
│       ├── weather_card.dart                # Main weather display card
│       ├── forecast_card.dart               # Single forecast day card
│       ├── weather_info_tile.dart           # Humidity/wind/pressure tile
│       └── search_bar_widget.dart           # City search bottom sheet
│
├── injection_container.dart                 # GetIt dependency setup
└── main.dart                                # App entry point
```

---

## 🔐 Security

API keys are stored in a local `.env` file which is listed in `.gitignore` and never uploaded to version control. Anyone cloning this repo must provide their own API key.

---

## 📱 Compatibility

| Platform | Status |
|---|---|
| Android | ✅ Supported |
| iOS | ✅ Supported |

---

## 👨‍💻 Author

**Talha Ul Islam**
- GitHub: [@talha123321](https://github.com/talha123321)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
