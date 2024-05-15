import 'package:flutter/material.dart';
import 'package:medical_healthcare/theme.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  ButtonPrimary({ required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: greenColor,
          foregroundColor: whiteColor, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}