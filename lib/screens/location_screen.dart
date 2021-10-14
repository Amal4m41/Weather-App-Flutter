import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/services/location.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;

  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late WeatherModel weatherModel;
  late String cityName;
  late num temperature;
  late String weatherIcon;
  late String weatherMessage;

  @override
  void initState() {
    super.initState();

    weatherModel = WeatherModel();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    print("LocationScreen state : $weatherData");

    setState(() {
      if (weatherData == null) {
        cityName = '';
        temperature = 0;
        weatherMessage = 'Unable to get weather data';
        weatherIcon = 'Error';
        return; //exit this function. (returning void)
      }

      cityName = weatherData["name"];

      temperature = weatherData["main"]["temp"];
      weatherMessage = weatherModel.getMessage(temperature.toInt());

      int weatherId = weatherData["weather"][0]["id"];
      weatherIcon = weatherModel.getWeatherIcon(weatherId);
    });
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
                    onPressed: () async {
                      var weatherData =
                          await weatherModel.getCurrentLocationWeatherData();

                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String? userInputResultCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext contextValue) {
                            return CityScreen();
                          },
                        ),
                      );

                      // print("RESULT : $result");
                      if (userInputResultCityName != null &&
                          userInputResultCityName.isNotEmpty) {
                        var weatherData = await weatherModel
                            .getCityWeatherData(userInputResultCityName);
                        updateUI(weatherData);
                      }
                    },
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
                  Text(
                    weatherIcon,
                    style: TextStyle(fontSize: 80),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 80, bottom: 30),
                child: Text(
                  "$weatherMessage in $cityName!",
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
