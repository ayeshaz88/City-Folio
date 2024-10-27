// ignore_for_file: file_names

import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/Header.dart';
import 'package:city_folio/Widgets/LocalInsightForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalInsights extends StatelessWidget {
  const LocalInsights({super.key});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Scaffold(
      body: SafeArea(
          child: Container(
              height: size.height,
              width: size.width,
              color: const Color(0xFFE8ECF4),
              child: Padding(
                padding: contentPadding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HomeHeader(title: 'Local Insights'.tr),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Upload Your Suggestion'.tr,
                        style: headingText.copyWith(
                            color: const Color(0xFF0000FF)),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const LocalInsigtForm(),
                    ],
                  ),
                ),
              ))),
    );
  }
}
