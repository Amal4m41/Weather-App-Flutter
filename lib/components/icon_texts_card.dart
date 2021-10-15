import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

class IconTextsCard extends StatelessWidget {
  IconData? icon;
  String textOne;
  String textTwo;

  IconTextsCard({
    this.icon,
    required this.textOne,
    required this.textTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.6),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.yellow,
            size: icon == null ? null : 50,
          ),
          Text(textOne),
          Text(
            textTwo,
            style: kTextStyle.copyWith(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
