import 'package:flutter/material.dart';
import 'package:medical_healthcare/main_page.dart';
import 'package:medical_healthcare/network/model/pref_profile_model.dart';
import 'package:medical_healthcare/pages/login_page.dart';
import 'package:medical_healthcare/widget/button_primary.dart';
import 'package:medical_healthcare/widget/general_logo_space.dart';
import 'package:medical_healthcare/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
      // ignore: unnecessary_null_comparison
      if (userID == null) {
        sessionLogout();
      } else {
        sessionLogin();
      }
    });
  }

  sessionLogout(){}
  sessionLogin(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              GeneralLogoSpace(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    WidgetIlustration( 
                      image: "assets/splash_ilustration.png",
                      title: "Find your medical\nsolution",
                      subtitle1: "Consult with the best doctors",
                      subtitle2: "Find the best doctors and get the best treatment",
                      child: ButtonPrimary(
                        text: "GET STARTED",
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
