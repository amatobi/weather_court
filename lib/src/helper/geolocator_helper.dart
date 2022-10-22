import 'package:geolocator/geolocator.dart';

enum GeoErrorType { disabled, noPermission, deniedForever }

class GeoLocatorHelper {
 static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(GeoErrorType.disabled);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(GeoErrorType.noPermission);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(GeoErrorType.deniedForever);
    }

    return await Geolocator.getCurrentPosition();
  }
}
