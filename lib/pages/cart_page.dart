import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_healthcare/network/api/url_api.dart';
import 'package:medical_healthcare/network/model/cart_model.dart';
import 'package:medical_healthcare/network/model/pref_profile_model.dart';
import 'package:medical_healthcare/theme.dart';
import 'package:medical_healthcare/widget/button_primary.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? userID, name, address, phone;
  int delivery = 0;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
      name = sharedPreferences.getString(PrefProfile.name);
      address = sharedPreferences.getString(PrefProfile.address);
      phone = sharedPreferences.getString(PrefProfile.phone);
    });
    if (userID != null) {
      getCart(userID!);
    }
  }

  List<CartModel> listCart = [];

  getCart(String userID) async {
    listCart.clear();
    var urlGetCart = Uri.parse(BASEURL.getProductCart + userID);
    final response = await http.get(urlGetCart);

    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          listCart.add(CartModel.fromJson(item));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: whiteColor,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24),
        height: 220,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xfffcfcfc),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Items",
                    style: regulerTextStyle.copyWith(
                      fontSize: 14,
                      color: greyBoldColor,
                    ),
                  ),
                  Text(
                    "IDR 180.000",
                    style: boldTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Fee",
                    style: regulerTextStyle.copyWith(
                      fontSize: 14,
                      color: greyBoldColor,
                    ),
                  ),
                  Text(
                    delivery == 0 ? "FREE" : "IDR $delivery",
                    style: boldTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Payment",
                    style: regulerTextStyle.copyWith(
                      fontSize: 14,
                      color: greyBoldColor,
                    ),
                  ),
                  Text(
                    "IDR 180.000",
                    style: boldTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ButtonPrimary(
                  onTap: () {},
                  text: "CHECKOUT NOW",
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
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
                height: 18,
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Destination",
                      style: regulerTextStyle.copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name",
                          style: regulerTextStyle.copyWith(
                            fontSize: 14,
                            color: greyBoldColor,
                          ),
                        ),
                        Text(
                          "$name",
                          style: boldTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address",
                          style: regulerTextStyle.copyWith(
                            fontSize: 14,
                            color: greyBoldColor,
                          ),
                        ),
                        Text(
                          "$address",
                          style: boldTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone",
                          style: regulerTextStyle.copyWith(
                            fontSize: 14,
                            color: greyBoldColor,
                          ),
                        ),
                        Text(
                          "$phone",
                          style: boldTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listCart.length,
                itemBuilder: (context, i) {
                  final x = listCart[i];
                  return Container(
                    padding: EdgeInsets.all(24),
                    color: whiteColor,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              x.image,
                              width: 115,
                              height: 100,
                            ),
                            SizedBox(width: 10), // Added space between image and column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    x.name,
                                    style: regulerTextStyle.copyWith(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: greenColor,
                                        ),
                                        onPressed: () {},
                                      ),
                                      Text(x.quantity.toString()),
                                      IconButton(
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Color(0xfff0997a),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  Text(
                                    x.price.toString(),
                                    style: boldTextStyle.copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
