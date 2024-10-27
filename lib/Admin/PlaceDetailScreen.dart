import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PlaceDetailScreen extends StatelessWidget {
  final String place_name;
  final String place_detail;
  final String place_location;
  final String image1_url;

  PlaceDetailScreen({
    required this.place_name,
    required this.place_detail,
    required this.place_location,
    required this.image1_url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                color: Colors.white,
                child: Padding(
                  padding: contentPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place_name.tr,
                        style: headerText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        place_location.tr,
                        style: TextStyle(color: AppColors().border_color),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        place_detail.tr,
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
    );
  }
}
