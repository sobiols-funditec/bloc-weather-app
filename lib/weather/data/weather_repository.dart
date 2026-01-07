import 'package:weather/weather.dart';
import 'package:weather_app/weather/data/services/weather_service.dart';

class WeatherRepository {
  final WeatherService _weatherService = WeatherService();

  Future<Weather> getWeatherByLocation({
    required double lat,
    required double lon,
  }) {
    return _weatherService.fetchCurrentWeather(latitude: lat, longitude: lon);
  }
}
