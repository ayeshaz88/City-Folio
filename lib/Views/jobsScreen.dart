// ignore_for_file: file_names

import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Constants/color.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/Header.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/JobWidget.dart';
import 'package:city_folio/Widgets/JobWidgets/AddJob.dart';
import 'package:city_folio/Widgets/JobWidgets/JobWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          color: const Color(0xFFE8ECF4),
          child: Padding(
            padding: contentPadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeHeader(title: 'Jobs'.tr),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const JobWidget(
                            documentId: 'frSHTFTiPOTaDeZXWrlW',
                          ));
                    },
                    child: DisplayCard(
                        companyName: 'IT Tech'.tr,
                        location: 'Wah Cantt'.tr,
                        role: 'Data Analyst'.tr,
                        salary: '1,50,000'.tr,
                        color: splashGradient2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() =>
                          const JobWidget(documentId: 'PIlU5II1FOC0DC74ZeDO'));
                    },
                    child: DisplayCard(
                        companyName: 'RUNCODE'.tr,
                        location: 'Hassan Abdal'.tr,
                        role: 'Software Engineer'.tr,
                        salary: '1,50,000'.tr,
                        color: splashGradient1),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() =>
                          const JobWidget(documentId: 'kyeZdTJxmEIebmxhQRon'));
                    },
                    child: DisplayCard(
                        companyName: 'Apple'.tr,
                        location: 'Wah Cantt'.tr,
                        role: 'Designer'.tr,
                        salary: '100,000'.tr,
                        color: splashGradient2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, right: 16.0),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => const AddJob());
            },
            child: Icon(Icons.post_add),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
