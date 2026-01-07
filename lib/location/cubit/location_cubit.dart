import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/location/data/location_repository.dart';

class LocationCubit extends Cubit<Position?> {
  LocationCubit({required LocationRepository locationRepository})
    : _locationRepository = locationRepository,
      super(null) {
    _locationSubscription = _locationRepository
        .onLocationChangedStream()
        .listen(_locationChanged);
  }

  final LocationRepository _locationRepository;
  late final StreamSubscription<Position> _locationSubscription;

  void _locationChanged(Position position) {
    emit(position);
  }

  @override
  Future<void> close() {
    _locationSubscription.cancel();
    return super.close();
  }
}
