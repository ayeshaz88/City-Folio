import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Pill extends StatelessWidget {
  const Pill(this.text, {super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: c26FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: contentPadding,
      child: Text(
        text.tr,
        style: TextStyle(
          fontSize: Get.height * 0.02,
          color: pureWhite,
        ),
      ),
    );
  }
}
