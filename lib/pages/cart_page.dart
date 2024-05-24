import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_healthcare/main_page.dart';
import 'package:medical_healthcare/network/api/url_api.dart';
import 'package:medical_healthcare/network/model/cart_model.dart';
import 'package:medical_healthcare/network/model/pref_profile_model.dart';
import 'package:medical_healthcare/pages/success_checkout.dart';
import 'package:medical_healthcare/theme.dart';
import 'package:medical_healthcare/widget/button_primary.dart';
import 'package:medical_healthcare/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final VoidCallback method;
  CartPage(this.method);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final price = NumberFormat("#,##0", "EN_US");
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
      cartTotalPrice();
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

  updateQuantity(String tipe, String model) async {
    var urlUpdateQuantity = Uri.parse(BASEURL.updateQuantityProductCart);
    final response = await http.post(urlUpdateQuantity, body: {
      "cartID": model,
      "tipe": tipe
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        getPref();
        widget.method();
      });
    } else {
      print(message);
      setState(() {
        getPref();
      });
    }
  }

  checkout() async {
    var urlCheckout = Uri.parse(BASEURL.checkout);
    final response = await http.post(urlCheckout, body: {
      "idUser": userID,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => SuccessCheckout()), 
        (route) => false);
    } else {
      print(message);
    }
  }

  var sumPrice = "0";
  int totalPayment = 0;
  cartTotalPrice() async {
    var urlTotalPrice = Uri.parse(BASEURL.totalPriceCart + userID!);
    final response = await http.get(urlTotalPrice);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String total = data['Total'];
      setState(() {
        sumPrice = total;
        // ignore: unnecessary_null_comparison
        totalPayment = sumPrice == null ? 0 : int.parse(sumPrice) + delivery;
      });
      print(sumPrice);
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
      bottomNavigationBar: listCart.isNotEmpty ? Container(
        padding: EdgeInsets.all(24),
        height: 234,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xfffcfcfc),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
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
                  "IDR " + price.format(int.parse(sumPrice)),
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
                  "IDR " + price.format(totalPayment),
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
                onTap: () {
                  checkout();
                },
                text: "CHECKOUT NOW",
              ),
            ),
          ],
        ),
      ) : null, // Hide if listCart is empty
      body: SafeArea(
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
            Expanded(
              child: listCart.isEmpty
                ? Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(top: 10),
                  child: WidgetIlustration(
                      image: "assets/empty_cart_ilustration.png",
                      title: "There are no products in your cart",
                      subtitle1: "Your cart is still empty",
                      subtitle2: "Find the products",
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: ButtonPrimary(
                          text: "SHOPPING NOW",
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage()),
                                (route) => false
                            );
                          },
                        ),
                      ),
                    ),
                )
                : ListView.builder(
                    itemCount: listCart.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delivery Destination",
                                style: regulerTextStyle.copyWith(
                                  fontSize: 18,
                                ),
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
                        );
                      } else {
                        int itemIndex = index - 1; // Adjust index for the header
                        return ListTile(
                          leading: Image.network(
                            listCart[itemIndex].image,
                            width: 115,
                            height: 100,
                          ),
                          title: Text(
                            listCart[itemIndex].name,
                            style: regulerTextStyle.copyWith(fontSize: 16),
                          ),
                          subtitle: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: greenColor,
                                ),
                                onPressed: () {
                                  updateQuantity("tambah", listCart[itemIndex].idCart);
                                },
                              ),
                              Text(listCart[itemIndex].quantity),
                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Color(0xfff0997a),
                                ),
                                onPressed: () {
                                  updateQuantity("kurang", listCart[itemIndex].idCart);
                                },
                              ),
                            ],
                          ),
                          trailing: Text(
                            "IDR" + price.format(int.parse(listCart[itemIndex].price)),
                            style: boldTextStyle.copyWith(fontSize: 16),
                          ),
                        );
                      }
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

