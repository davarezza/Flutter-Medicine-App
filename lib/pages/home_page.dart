import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_healthcare/network/api/url_api.dart';
import 'package:medical_healthcare/network/model/pref_profile_model.dart';
import 'package:medical_healthcare/network/model/product_model.dart';
import 'package:medical_healthcare/pages/cart_page.dart';
import 'package:medical_healthcare/pages/detail_product.dart';
import 'package:medical_healthcare/pages/search_product.dart';
import 'package:medical_healthcare/theme.dart';
import 'package:medical_healthcare/widget/card_category.dart';
import 'package:http/http.dart' as http;
import 'package:medical_healthcare/widget/card_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int index;
  bool filter = false;
  List<CategoryWithProduct> listCategory = [];
  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.apiGetProductWithCategory);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body) as List<dynamic>;
        for (var item in data) {
          listCategory
              .add(CategoryWithProduct.fromJson(item as Map<String, dynamic>));
        }
      });
      getProduct();
      totalCart();
    }
  }

  List<ProductModel> listProduct = [];
  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.apiGetProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body) as List<dynamic>;
        for (var product in data) {
          listProduct
              .add(ProductModel.fromJson(product as Map<String, dynamic>));
        }
      });
    }
  }

  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
    });
  }

  var jumlahCart = "0";
  totalCart() async {
    var urlGetTotalCart = Uri.parse(BASEURL.getTotalCart + userID);
    final response = await http.get(urlGetTotalCart);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      String jumlah = data['Jumlah'];
      setState(() {
        jumlahCart = jumlah;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 155,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Find a Medicine or\nVitamins with MEDHEALTH!",
                      style: regulerTextStyle.copyWith(
                          fontSize: 15, color: greyBoldColor),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage(totalCart)));
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: greenColor,
                      ),
                    ),
                    jumlahCart == "0"
                        ? SizedBox.shrink()
                        : Positioned(
                            right: 6,
                            top: 3,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  jumlahCart,
                                  style: regulerTextStyle.copyWith(
                                      color: whiteColor, fontSize: 12),
                                      textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchProduct()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffe0f7fa)),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xff0288d1),
                    ),
                    hintText: "Search Medicine ...",
                    hintStyle:
                        regulerTextStyle.copyWith(color: Color(0xff0288d1)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Medicine & Vitamins by Category",
              style: regulerTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 14,
            ),
            Flexible(
              child: GridView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: listCategory.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, i) {
                  final x = listCategory[i];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        index = i;
                        filter = true;
                        print("$index, $filter");
                      });
                    },
                    child: CardCategory(
                      imageCategory: x.image,
                      nameCategory: x.category,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Product",
              style: regulerTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 14,
            ),
            filter
                ? index == 7
                    ? Text("Feature on development")
                    : GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: listCategory[index].product.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, i) {
                          final y = listCategory[index].product[i];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailProduct(
                                            productModel: y,
                                          )));
                            },
                            child: CardProduct(
                              nameProduct: y.nameProduct,
                              imageProduct: y.imageProduct,
                              priceProduct: y.price,
                            ),
                          );
                        },
                      )
                : GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listProduct.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, i) {
                      final y = listProduct[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProduct(
                                        productModel: y,
                                      )));
                        },
                        child: CardProduct(
                          nameProduct: y.nameProduct,
                          imageProduct: y.imageProduct,
                          priceProduct: y.price,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
