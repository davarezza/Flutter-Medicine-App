import 'package:flutter/material.dart';
import 'package:medical_healthcare/main_page.dart';
import 'package:medical_healthcare/widget/button_primary.dart';
import 'package:medical_healthcare/widget/general_logo_space.dart';
import 'package:medical_healthcare/widget/widget_ilustration.dart';

class SuccessCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(
              height: 26,
            ),
            WidgetIlustration(
              image: "assets/order_success_ilustration.png",
              title: "Yeay, you have been done checkout",
              subtitle1: "Consult with a doctor",
              subtitle2: "Whatever and whenever you want",
              child: SizedBox.shrink(),
            ),
            SizedBox(
              height: 8,
            ),
            ButtonPrimary(
              text: "BACK TO HOME",
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (context) => MainPage()), 
                  (route) => false);
              },
            ),
          ],
        ), 
      ),
    );
  }
}