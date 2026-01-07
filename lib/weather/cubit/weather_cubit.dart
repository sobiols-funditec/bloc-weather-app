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

    try {
      emit(WeatherLoading());

      final weather = await _weatherRepository.getWeatherByLocation(
        lat: position.latitude,
        lon: position.longitude,
      );

      // 🔴 FILTRO IMPORTANTE
      if (weather.areaName == _lastAreaName) return;

      _lastAreaName = weather.areaName;
      emit(WeatherSuccess(weather));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _locationSubscription.cancel();
    return super.close();
  }
}
