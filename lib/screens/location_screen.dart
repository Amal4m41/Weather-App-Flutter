import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/utils/constants.dart';
import 'city_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/components/text_card.dart';
import 'package:weather_app/components/icon_texts_card.dart';

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
  late String weatherMain;
  late String weatherDescription;
  late int sunriseTime;
  late int sunsetTime;
  late String country;
  late num humidity;

  @override
  void initState() {
    super.initState();

    weatherModel = WeatherModel();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    print("updateUI weatherData : $weatherData");

    setState(() {
      if (weatherData == null) {
        cityName = '';
        temperature = 0;
        weatherMessage = 'Unable to get weather data';
        weatherIcon = 'Error';
        weatherMain = "Error";
        sunriseTime = 0;
        sunsetTime = 0;
        weatherDescription = "";
        humidity = 0;
        country = "None";
        return; //exit this function. (returning void)
      }

      cityName = weatherData["name"];

      temperature = weatherData["main"]["temp"];
      weatherMessage = weatherModel.getMessage(temperature.toInt());

      weatherMain = weatherData["weather"][0]["main"];
      weatherDescription = weatherData["weather"][0]["description"];

      int weatherId = weatherData["weather"][0]["id"];
      weatherIcon = weatherModel.getWeatherIcon(weatherId);

      //Get epoch timestamp(in seconds) w.r.t the location timezone.
      sunriseTime = weatherData["sys"]["sunrise"] + weatherData["timezone"];
      sunsetTime = weatherData["sys"]["sunset"] + weatherData["timezone"];
      country = weatherData["sys"]["country"];

      humidity = weatherData["main"]["humidity"];
      // print(sunriseTime);
      // print(sunsetTime);
    });
  }

  String getTimeInString(int timestamp) {
    //Time is already converted into the location's timezone, but we are converting the time to utc so that it's not
    //converted into locale again.
    DateTime timeInUtc =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toUtc();
    print(timeInUtc);
    return "${timeInUtc.hour} : ${timeInUtc.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath + 'waterfall.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.withOpacity(0.2),
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.7),
                Colors.black12.withOpacity(0.1),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weatherModel
                            .getCurrentLocationWeatherData(context);

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weatherMain,
                        style: kTextStyle,
                      ),
                      Text(
                        weatherDescription,
                        style: kTextStyle.copyWith(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${temperature.toInt()}°",
                            style: kTextStyle.copyWith(fontSize: 100),
                          ),
                          Text(
                            weatherIcon,
                            style: TextStyle(fontSize: 60),
                          ),
                          TextCard(
                            titleText: "Humidity",
                            text: humidity.toString() + "%",
                            cardBgColor: Colors.orange.withOpacity(0.5),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconTextsCard(
                        icon: Icons.wb_sunny,
                        textOne: "Sunrise",
                        textTwo: getTimeInString(sunriseTime),
                      ),
                      IconTextsCard(
                        icon: Icons.wb_sunny_outlined,
                        textOne: "Sunset",
                        textTwo: getTimeInString(sunsetTime),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 30, right: 5),
                  child: Text(
                    "$weatherMessage in $cityName, $country",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
