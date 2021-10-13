import 'package:geolocator/geolocator.dart';

class Location {
  late double _lat;
  late double _lng;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      _lat = position.latitude;
      _lng = position.longitude;
      // print('$lat $lng');
    } catch (e) {
      print(e);
    }
  }

  double getLatitude() => _lat;
  double getLongitude() => _lng;
}
