// ignore_for_file: file_names

import 'dart:developer';

import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Views/LocalInsights.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/CityWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeScreenWidget extends StatelessWidget {
  late String selectedCity;
  HomeScreenWidget({super.key, required this.selectedCity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
              bottom: 20.0,
              right: 16.0), // Adjust bottom and right values as needed
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => const LocalInsights());
            },
            child: Icon(Icons
                .share_location), // Change the icon to your desired business icon
            backgroundColor:
                Colors.blue, // Change the background color as needed
          ),
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          color: const Color(0xFFE8ECF4),
          child: Padding(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Popular Destinations'.tr,
                  style: boldHeading,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  height: Get.height * 0.65,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('places')
                                .where('cityName', isEqualTo: selectedCity)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final List<DocumentSnapshot> documents =
                                    snapshot.data!.docs;
                                log(documents.length.toString());
                                return ListView(
                                    children: documents
                                        .map((doc) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CityWidget(
                                                cityname: doc['cityName'],
                                                placeDescription:
                                                    doc['placeDescription'],
                                                placeImage1: doc['placeImage1'],
                                                placeImage2: doc['placeImage2'],
                                                placeName: doc['placeName'])))
                                        .toList());
                              } else {
                                return Center(
                                    child: Text('No Data Found'.tr));
                              }
                            },
                          ),
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
