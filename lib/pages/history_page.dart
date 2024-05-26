import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_healthcare/network/api/url_api.dart';
import 'package:medical_healthcare/network/model/history_model.dart';
import 'package:medical_healthcare/network/model/pref_profile_model.dart';
import 'package:medical_healthcare/theme.dart';
import 'package:medical_healthcare/widget/card_history.dart';
import 'package:medical_healthcare/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryDetailModel> list = [];
  late String userID;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
    });
    getHistory();
  }

  getHistory() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.historyOrder + userID);
    final response = await http.post(urlHistory);
    if (response.statusCode == 200) {
      setState(() {
        final List<dynamic> dataList = jsonDecode(response.body);
        for (Map<String, dynamic> item in dataList) {
          list.add(HistoryDetailModel.fromJson(item));
        }
        // print(list[0].idUser);
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
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 80,
              child: Text(
                "History Orders",
                style: regulerTextStyle.copyWith(
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: (list.length == 0) ? 60 : 20,
            ),
            list.length == 0
                ? Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: WidgetIlustration(
                        image: "assets/no_history_ilustration.png",
                        title: "There are no history orders",
                        subtitle1: "You dont have any orders",
                        child: SizedBox.shrink(),
                        subtitle2: "Let's shopping now !",
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final x = list[i];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        child: CardHistory(
                          model: x,
                        ),
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
