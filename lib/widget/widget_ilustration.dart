import 'package:flutter/material.dart';
import 'package:medical_healthcare/theme.dart';

class WidgetIlustration extends StatelessWidget {
  final Widget child;
  final String image;
  final String title;
  final String subtitle1;
  final String subtitle2;

  WidgetIlustration({
    required this.child,
    required this.image,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding to avoid edge overflow
      child: Column(
        children: [
          Image.asset(
            image,
            width: 230,
          ),
          SizedBox(height: 25),
          Text(
            title,
            style: regulerTextStyle.copyWith(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Column(
            children: [
              Text(
                subtitle1,
                style: regulerTextStyle.copyWith(fontSize: 15, color: greyLightColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3),
              Text(
                subtitle2,
                style: regulerTextStyle.copyWith(fontSize: 15, color: greyLightColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              child,
            ],
          ),
        ],
      ),
    );
  }
}
