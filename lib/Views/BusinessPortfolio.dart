import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Views/BusinessPortfolioWidgets/AddBusiness.dart';
import 'package:city_folio/Views/BusinessPortfolioWidgets/PortfolioCard.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/BusinessWidget.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/Header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessPortfolio extends StatefulWidget {
  const BusinessPortfolio({Key? key}) : super(key: key);

  @override
  _BusinessPortfolioState createState() => _BusinessPortfolioState();
}

class _BusinessPortfolioState extends State<BusinessPortfolio> {
  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            bottom: 20.0,
            right: 16.0), // Adjust bottom and right values as needed
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddBusiness());
          },
          child: const Icon(Icons
              .add_business), // Change the icon to your desired business icon
          backgroundColor: Colors.blue, // Change the background color as needed
        ),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          color: const Color(0xFFE8ECF4),
          child: Padding(
            padding: contentPadding,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      HomeHeader(title: 'Business Portfolio'.tr),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const BusinessWidget(
                              documentId: 'FJfhTSSe6FtL8Xbd7vb2'));
                        },
                        child: BusinessCard(
                          pictureUrl:
                              'https://pas-wordpress-media.s3.us-east-1.amazonaws.com/content/uploads/2014/07/shutterstock_176646242.jpg',
                          companyName: 'Yums Bakers'.tr,
                          companyLogoUrl:
                              'https://th.bing.com/th/id/R.5223db083ac37d566ed669fda241fee7?rik=51cZhE7xLwCrLQ&pid=ImgRaw&r=0',
                          pricing: 'Bakery Products'.tr,
                          address: 'Taxila'.tr,
                          businessData: {},
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const BusinessWidget(
                              documentId: 'vUQj2ZFjv4hmEm6SaeGh'));
                        },
                        child: BusinessCard(
                          pictureUrl:
                              'https://th.bing.com/th/id/OIP.Vmgj53lEFqJuRwX5B6s-cAHaE8?rs=1&pid=ImgDetMain',
                          companyName: 'Karachi Biryani House'.tr,
                          companyLogoUrl:
                              'https://i.pinimg.com/originals/2b/58/2b/2b582b6f188083f89f8dd9065fa7aec0.jpg',
                          pricing: 'Lunch Biryani'.tr,
                          address: 'Taxila'.tr,
                          businessData: {},
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const BusinessWidget(
                              documentId: 'kwEndHchMPq3eDCUTnp4'));
                        },
                        child: BusinessCard(
                          pictureUrl:
                              'https://s3-media3.fl.yelpcdn.com/bphoto/A13QhBQhACmfoULf3KWAiw/168s.jpg',
                          companyName: 'Al-Khair Caterers & Event Planners'.tr,
                          companyLogoUrl:
                              'https://th.bing.com/th/id/R.2c978de57e44fa690f1c0e4f3f03388e?rik=GDaB4h5mFFLH0A&pid=ImgRaw&r=0',
                          pricing: 'Breakfast, lunch, dinner'.tr,
                          address: 'Wah Cantt'.tr,
                          businessData: {},
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
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
