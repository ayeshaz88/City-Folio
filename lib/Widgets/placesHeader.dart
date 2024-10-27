// ignore_for_file: file_names

import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Utils/colors.dart';
import 'package:city_folio/Views/LocalInsights.dart';
import 'package:city_folio/Views/favoritePlaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PlaceHeader extends StatelessWidget {
  String title;
  PlaceHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => const LocalInsights());
          },
          child: SizedBox(
            width: Get.width * 0.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.add,
                  size: 25,
                  color: AppColors().primary_color,
                ),
                Text(
                  'Suggest a Place'.tr,
                  style: TextStyle(color: AppColors().primary_color),
                )
              ],
            ),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(const FavoritePlaces());
              },
              child: Icon(
                Icons.favorite,
                color: AppColors().sec_color,
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Text(
              title.tr,
              style: headerText,
            ),
          ],
        ),
      ],
    );
  }
}
