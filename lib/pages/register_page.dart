import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_healthcare/network/api/url_api.dart';
import 'package:medical_healthcare/theme.dart';
import 'package:medical_healthcare/widget/button_primary.dart';
import 'package:medical_healthcare/widget/general_logo_space.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  registerSubmit() async {
    var registerUrl = Uri.parse(BASEURL.apiRegister);
    final response = await http.post(registerUrl, body: {
      "fullname": _name.text,
      "email": _email.text,
      "phone": _phone.text,
      "address": _address.text,
      "password": _password.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if(value == 1) {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text("Information"),
          content: Text(message),
          actions: [TextButton(onPressed: () {}, child: Text("OK"),)],
        )
      );
      setState(() {});
    } else {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text("Information"),
          content: Text(message),
          actions: [TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("OK"),)],
        )
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: GeneralLogoSpace(child: SizedBox.shrink(),),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "REGISTER",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                Text(
                  "Register new your account",
                  style: regulerTextStyle.copyWith(fontSize: 15, color: greyLightColor),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0
                      )
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0
                      )
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Address',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0
                      )
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0
                      )
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _address,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Home Address',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0
                      )
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _password,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: 'REGISTER',
                    onTap: () {
                      if (_name.text.isEmpty || _email.text.isEmpty || _phone.text.isEmpty || _address.text.isEmpty || _password.text.isEmpty) {
                        showDialog(
                          context: context, 
                          builder: (context) => AlertDialog(
                            title: Text("Warning"),
                            content: Text("Please fill all the field"),
                            actions: [TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("OK"),)],
                          )
                        );
                      } else {
                        registerSubmit();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: lightTextStyle.copyWith(
                        color: greyLightColor, fontSize: 14,
                      ),
                    ),
                    Text(
                      "Login Now",
                      style: boldTextStyle.copyWith(
                        color: greenColor, fontSize: 14,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

