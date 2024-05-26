import 'package:flutter/material.dart';
import 'package:medical_healthcare/network/model/pref_profile_model.dart';
import 'package:medical_healthcare/pages/login_page.dart';
import 'package:medical_healthcare/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String fullName, createdDate, phone, email, address;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullName = sharedPreferences.getString(PrefProfile.name)!;
      createdDate = sharedPreferences.getString(PrefProfile.createdAt)!;
      phone = sharedPreferences.getString(PrefProfile.phone)!;
      email = sharedPreferences.getString(PrefProfile.email)!;
      address = sharedPreferences.getString(PrefProfile.address)!;
    });
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefProfile.idUser);
    sharedPreferences.remove(PrefProfile.name);
    sharedPreferences.remove(PrefProfile.email);
    sharedPreferences.remove(PrefProfile.phone);
    sharedPreferences.remove(PrefProfile.address);
    sharedPreferences.remove(PrefProfile.createdAt);

    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => LoginPage()), 
      (route) => false
    );
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile",
                  style: boldTextStyle.copyWith(
                    fontSize: 24,
                  ),
                ),
                InkWell(
                  onTap: () {
                    signOut();
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    color: greenColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: boldTextStyle.copyWith(fontSize: 17),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Join at" + createdDate,
                  style: lightTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phone",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  phone,
                  style: boldTextStyle.copyWith(fontSize: 17),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  email,
                  style: boldTextStyle.copyWith(fontSize: 17),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  address,
                  style: boldTextStyle.copyWith(fontSize: 17),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

