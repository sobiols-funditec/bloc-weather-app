import 'package:weather/weather.dart';
import 'package:equatable/equatable.dart';

sealed class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherFailure extends WeatherState {
  final String error;

  WeatherFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class WeatherSuccess extends WeatherState {
  final Weather weather;

  WeatherSuccess(this.weather);

  @override
  List<Object> get props => [weather];
}
