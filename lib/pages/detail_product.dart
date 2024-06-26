import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_healthcare/main_page.dart';
import 'package:medical_healthcare/network/api/url_api.dart';
import 'package:medical_healthcare/network/model/pref_profile_model.dart';
import 'package:medical_healthcare/network/model/product_model.dart';
import 'package:medical_healthcare/theme.dart';
import 'package:medical_healthcare/widget/button_primary.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;

  DetailProduct({required this.productModel});
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final priceFormat = NumberFormat("#,##0", "EN_US");

  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
    });
  }

  addToCart() async {
    var urlAddToCart = Uri.parse(BASEURL.addToCart);
    final response = await http.post(urlAddToCart, body: {
      "id_user": userID,
      'id_product': widget.productModel.idProduct,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              title: Text("Information"),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => MainPage()), 
                      (route) => false
                    );
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          );
        },
      );
      setState(() {});
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              title: Text("Information"),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          );
        },
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

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
                    "Detail Product",
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
            Container(
              height: 200,
              color: whiteColor,
              child: Image.network(
                widget.productModel.imageProduct,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productModel.nameProduct,
                    style: regulerTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.productModel.description,
                    style: regulerTextStyle.copyWith(
                      fontSize: 14,
                      color: greyBoldColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "Rp ${priceFormat.format(int.parse(widget.productModel.price))}",
                        style: boldTextStyle.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      text: "ADD TO CART", 
                      onTap: () {
                        addToCart();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
