


import 'package:flutter/material.dart';
import 'package:medical_healthcare/pages/splash_screen.dart';
import 'package:medical_healthcare/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: greenColor),
      home: SplashScreen(),
    );
  }
}

