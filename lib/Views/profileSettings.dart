// ignore_for_file: file_names

import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/Header.dart';
import 'package:city_folio/Widgets/profileUpdateForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});
  static const Color myColor = Color(0xFF5386E4);

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            color: const Color(0xFFE8ECF4),
            child: Padding(
              padding: contentPadding,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeHeader(title: 'Update your profile'.tr),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Update Your Profile'.tr,
                      style: headingText.copyWith(
                        color: myColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const ProfileUpdateForm(),
                  ],
                ),
              ),
            )));
  }
}
