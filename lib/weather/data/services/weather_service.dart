import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class WeatherService {
  WeatherFactory weatherFactory = WeatherFactory(
    "65704d74b2c3aaa7d54201c0fa5352ee",
    language: Language.ENGLISH,
  );

  Future<Weather> fetchCurrentWeather({
    required double latitude,
    required double longitude,
  }) async =>
      await weatherFactory.currentWeatherByLocation(latitude, longitude);
}
