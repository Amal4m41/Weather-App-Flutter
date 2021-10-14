import 'package:flutter/material.dart';

import 'package:weather_app/services/location.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getLocationAndWeather() async {
    var weatherData = await WeatherModel().getCurrentLocationWeatherData();
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
    getLocationAndWeather();
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
