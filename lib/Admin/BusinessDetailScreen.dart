import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BusinessDetailScreen extends StatelessWidget {
  final String businessDetail;
  final String businessLocation;
  final String businessName;
  final String image1_url;

  BusinessDetailScreen({
    required this.businessName,
    required this.businessLocation,
    required this.businessDetail,
    required this.image1_url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Container(
            height: Get.height,
            width: Get.width,
            color: const Color(0xFFE8ECF4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.4,
                  width: Get.width,
                  child: Image.network(
                    image1_url,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: Get.width,
                  color: Colors.white,
                  child: Padding(
                    padding: contentPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          businessName.tr,
                          style: headerText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          businessLocation.tr,
                          style: TextStyle(color: AppColors().border_color),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          businessDetail.tr,
                          // Set maxLines to null for multiline input
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
