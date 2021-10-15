import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/utils/constants.dart';

class CityScreen extends StatelessWidget {
  String? cityName = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(imagePath + 'pinkSky.jpg'),
              fit: BoxFit.fill,
            )),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.white.withOpacity(0.3),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        size: 50,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      //Called when the user initiates a change to the TextField's value: when they have inserted or deleted text.
                      onChanged: (String textValue) {
                        cityName = textValue;
                      },
                      // onSubmitted: (String text) {
                      //   print(text);
                      // },
                      style: TextStyle(color: Colors.black),
                      decoration: kTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.grey.withOpacity(0.5),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, cityName);
                    },
                    child: Text("Get Weather",
                        style: kTextStyle.copyWith(fontSize: 30)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
