import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/widget/card_text.dart';

class item_card extends StatelessWidget {
  final String cardText;
  final double fontSize;
  final Animation<double> animation;
  const item_card(
      {super.key,
      required this.cardText,
      required this.fontSize,
      required this.animation});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
          width: Get.width * 0.9,
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
            horizontal: Get.width * 0.03,
          ),
          margin: EdgeInsets.symmetric(
            vertical: Get.width * 0.02,
            horizontal: Get.width * 0.05,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 191, 200, 221),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 2.0),
                ),
              ]),
          child: card_text(
            fontSize: fontSize,
            cardText: cardText,
          )),
    );
  }
}
