import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sa_localizacao_mapa/models/location_point_model.dart';

class MapService {
  final DateFormat _format = DateFormat("dd/MM/yyyy - HH:mm:ss");

  Future<LocationPointModel> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }

    Position position = await Geolocator.getCurrentPosition();

    String dateTime = _format.format(DateTime.now());
    LocationPointModel point = LocationPointModel(
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: dateTime,
    );

    return point; 
  }
}
