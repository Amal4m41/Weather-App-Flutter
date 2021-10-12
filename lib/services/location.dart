import 'package:geolocator/geolocator.dart';

class Location {
  late double lat;
  late double lng;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      lat = position.latitude;
      lng = position.longitude;
      print('$lat $lng');
    } catch (e) {
      print(e);
    }
  }
}
