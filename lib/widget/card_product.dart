import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_healthcare/theme.dart';

class CardProduct extends StatelessWidget {
  final String imageProduct;
  final String nameProduct;
  final String priceProduct;

  CardProduct({required this.imageProduct, required this.nameProduct, required this.priceProduct});
  @override
  Widget build(BuildContext context) {
    final priceFromat = NumberFormat("#,##0", "EN_US");
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            imageProduct,
            width: 98,
            height: 64,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            nameProduct,
            style: regulerTextStyle,
            textAlign: TextAlign.center,
            ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Rp " + priceFromat.format(int.parse(priceProduct)),
            style: boldTextStyle,
          ),
        ],
      ),
    );
  }
}

