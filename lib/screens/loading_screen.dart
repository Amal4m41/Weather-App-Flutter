import 'package:flutter/material.dart';
import 'package:weather_app/services/networking.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double lat;
  late double lng;

  Future<void> getLocation() async {
    Location loc = Location();

    await loc.getCurrentLocation();

    lat = loc.getLatitude();
    lng = loc.getLongitude();
    print(lat);
    print(lng);

    getWeatherData();
  }

  void getWeatherData() async {
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lng}&units=metric&appid=$apiKey');

    //will get the map object if it's a successful api call, otherwise null
    var weatherData = await networkHelper.getData();

    // Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            weatherData: weatherData,
          );
        },
      ),
    );
  }

  /*
  Called when this object is inserted into the tree.
The framework will call this method exactly once for each State object it creates.
Override this method to perform initialization that depends on the location at which this object was inserted into the tree (i.e., context) or on the widget used to configure this object (i.e., widget).
   */
  @override
  void initState() {
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeInOut(
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }

  @override
  void deactivate() {}
}
