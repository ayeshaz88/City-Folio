// ignore_for_file: file_names

import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Utils/colors.dart';
import 'package:city_folio/Views/HomeScreenWidgets/homeScreen.dart';
import 'package:city_folio/Views/WeatherScreen.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/Header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SelectCity extends StatelessWidget {
  SelectCity({super.key});
  String city_a = 'Wah Cantt';
  String city_b = 'Taxila';
  String city_c = 'Hassan Abdal';

  void navigateToSelectedCity(String selectedCity) {
    // Navigate to the selected city
    Get.to(() => HomeScreenWidget(selectedCity: selectedCity));
  }

  void openGoogleMaps(String location) async {
    String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$location";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFE8ECF4),
        child: Padding(
          padding: contentPadding,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                HomeHeader(title: 'Select City'.tr),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                _buildCityContainer(
                    city_a, Icons.location_on, Icons.cloud, context),
                const SizedBox(
                  height: 20,
                ),
                _buildCityContainer(
                    city_b, Icons.location_on, Icons.cloud, context),
                const SizedBox(
                  height: 20,
                ),
                _buildCityContainer(city_c.toUpperCase(), Icons.location_on,
                    Icons.cloud, context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCityContainer(String city, IconData locationIcon,
      IconData weatherIcon, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => HomeScreenWidget(selectedCity: city));
            },
            child: Container(
              height: Get.height * 0.2,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(97, 25, 6, 54),
                boxShadow: [
                  BoxShadow(
                    color: AppColors().border_color.withOpacity(0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/${city.toLowerCase()}.jpg',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Text(
                        city.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                openGoogleMaps(city);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  locationIcon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Get.to(() => WeatherScreen(city: city));
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  weatherIcon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
