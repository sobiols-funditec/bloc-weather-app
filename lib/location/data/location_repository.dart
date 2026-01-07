import 'package:geolocator/geolocator.dart';
import 'package:weather_app/location/data/services/geolocator_service.dart';

class LocationRepository {
  final GeolocatorService _geolocatorService = GeolocatorService();

  Future<Position> getCurrentPosition() => _geolocatorService.getCurrentPosition();
  Stream<Position> onLocationChangedStream() => _geolocatorService.onLocationChangedStream();
  
}
