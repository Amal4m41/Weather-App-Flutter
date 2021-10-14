import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/services/networking.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/utils/constants.dart';

class WeatherModel {
  //Fetch the current location of the user and then get the weather for the same.
  Future<dynamic> getCurrentLocationWeatherData() async {
    Location loc = Location();

    await loc.getCurrentLocation();

    double lat = loc.getLatitude();
    double lng = loc.getLongitude();
    print(lat);
    print(lng);

    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lng}&units=metric&appid=$apiKey');

    //will get the map object if it's a successful api call, otherwise null
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition <= 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
