import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Location loc;

  Future<void> getLocation() async {
    loc = Location();

    await loc.getCurrentLocation();
    print(loc.lat);
    print(loc.lng);
  }

  void getWeatherData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${loc.lat}&lon=${loc.lng}&appid=$apiKey'));

    if (response.statusCode == 200) {
      //The json data is always converted into string for effective transmission of data.
      String body = response.body;

      //Parses the string and returns the resulting Json object
      // print(jsonDecode(body)["weather"][0]["description"]); //weather[0].description
      print(jsonDecode(body)["main"]["temp"]);
    } else {
      print(response.statusCode);
    }
  }

  void getLocAndWeather() async {
    print("BEFORE");
    await getLocation(); //wait for the location data to be fetched.
    print("AFTER");
    getWeatherData();
  }

  /*
  Called when this object is inserted into the tree.
The framework will call this method exactly once for each State object it creates.
Override this method to perform initialization that depends on the location at which this object was inserted into the tree (i.e., context) or on the widget used to configure this object (i.e., widget).
   */
  @override
  void initState() {
    getLocAndWeather();
    print("AFTER LOCATION");
  }

  @override
  Widget build(BuildContext context) {
    try {
      getWeatherData();
    } catch (e) {
      print(e);
    }

    return Scaffold(
      body: Center(),
    );
  }

  @override
  void deactivate() {}
}
