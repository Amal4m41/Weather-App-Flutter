import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // precacheImage(AssetImage("images/bridge.jpg"), context);
    // precacheImage(AssetImage("images/weatherBg.jpg"), context);
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
