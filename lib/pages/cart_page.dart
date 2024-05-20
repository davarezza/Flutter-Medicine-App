import 'package:flutter/material.dart';
import 'package:medical_healthcare/theme.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 32,
                      color: greenColor,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "My Cart",
                    style: regulerTextStyle.copyWith(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}

