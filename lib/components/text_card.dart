import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

class TextCard extends StatelessWidget {
  String titleText;
  String text;
  Color cardBgColor;

  TextCard({
    required this.titleText,
    required this.text,
    this.cardBgColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Text(titleText),
          Text(
            text,
            style: kTextStyle.copyWith(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
