import 'dart:async';

import 'package:weather/weather.dart';
import 'package:weather_app/weather/constants/weather.dart';

class WeatherService {
  WeatherFactory weatherFactory = WeatherFactory(
    kCloudApiKey,
    language: Language.ENGLISH,
  );

  Future<Weather> fetchCurrentWeather({
    required double latitude,
    required double longitude,
  }) async =>
      await weatherFactory.currentWeatherByLocation(latitude, longitude);
}
