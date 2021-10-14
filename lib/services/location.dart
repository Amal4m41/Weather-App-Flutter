import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class Location {
  late double _lat;
  late double _lng;

  Future<void> getCurrentLocation(BuildContext context) async {
    //Request permission to access the location of the device.
    // Returns a Future which when completes indicates if the user granted permission to access the device's location.
    LocationPermission permission = await Geolocator.requestPermission();
    print(permission);

    if (permission == LocationPermission.denied) {
      // print("DENIED");
    } else if (permission == LocationPermission.deniedForever) {
      String? result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Location Permission'),
          content: const Text(
              'You have permanently denied the permission required to access '
              'your location. You can enable the permission from app settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, "cancel"),
              child: const Text('Deny'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context,
                  "ok"), //this value("ok") will be returned if the user has chosen it.
              child: const Text('Go to app settings'),
            ),
          ],
        ),
      );
      if (result == "ok") {
        print(
            "${await Geolocator.openAppSettings()}"); //go to the this app's settings
      }
    } else {
      try {
        //takes care of getting the current location, as well as checking if the location service is enabled in the device.
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);

        _lat = position.latitude;
        _lng = position.longitude;
        // print('$lat $lng');
      } catch (e) {
        print("getCurrentLocation : $e");
      }
    }
  }

  double getLatitude() => _lat;
  double getLongitude() => _lng;
}
