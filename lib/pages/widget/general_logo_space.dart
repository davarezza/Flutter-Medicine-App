import 'package:flutter/material.dart';

class GeneralLogoSpace extends StatelessWidget {
  final Widget child;

  GeneralLogoSpace({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 26),
          Image.asset(
            "assets/logo.png",
            width: 115,
          ),
          SizedBox(height: 12), 
          child,
        ],
      ),
    );
  }
}
