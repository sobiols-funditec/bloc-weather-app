import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/location/cubit/location_cubit.dart';
import 'package:weather_app/weather/cubit/weather_state.dart';
import 'package:weather_app/weather/data/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required WeatherRepository weatherRepository,
    required LocationCubit locationCubit,
  }) : _weatherRepository = weatherRepository,
       _locationCubit = locationCubit,
       super(WeatherInitial()) {
    _locationSubscription = _locationCubit.stream.listen(_onLocationChanged);
  }

  final WeatherRepository _weatherRepository;
  final LocationCubit _locationCubit;
  late final StreamSubscription<Position?> _locationSubscription;

  String? _lastAreaName;

  Future<void> _onLocationChanged(Position? position) async {
    if (position == null) return;

    // Si la posición sigue siendo dentro de la misma área aproximada, no hacemos nada
    final approxArea = _approximateArea(position);
    if (approxArea == _lastAreaName) return;

    _lastAreaName = approxArea;

    try {
      emit(WeatherLoading());
      final weather = await _weatherRepository.getWeatherByLocation(
        lat: position.latitude,
        lon: position.longitude,
      );

      _lastAreaName = weather.areaName;
      emit(WeatherSuccess(weather));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }

  /// Función para aproximar el área según coordenadas
  String _approximateArea(Position position) {
    // Redondeamos lat/lon a 2 decimales (≈1 km de precisión)
    final lat = position.latitude.toStringAsFixed(2);
    final lon = position.longitude.toStringAsFixed(2);
    return '$lat,$lon';
  }

  @override
  Future<void> close() {
    _locationSubscription.cancel();
    return super.close();
  }
}
