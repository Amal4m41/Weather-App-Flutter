import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;

  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var weatherData;
  late String cityName;
  late double temperature;
  late String weatherCondition;
  late String weatherDescription;

  @override
  void initState() {
    super.initState();

    print("LocationScreen state : ${widget.weatherData}");
    weatherData = widget.weatherData;

    cityName = weatherData["name"];
    temperature = weatherData["main"]["temp"];
    weatherCondition = weatherData["weather"][0]["main"];
    weatherDescription = weatherData["weather"][0]["description"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/weatherBg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${temperature.toInt()}°",
                    style: TextStyle(
                      fontSize: 90,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Icon(
                    Icons.wb_sunny,
                    color: Colors.yellow,
                    size: 90,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 80, bottom: 30),
                child: Text(
                  "It's $weatherCondition, $weatherDescription in $cityName!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
