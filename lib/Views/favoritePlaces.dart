// ignore_for_file: file_names

import 'dart:developer';
import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/Header.dart';
import 'package:city_folio/savedPlaceWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePlaces extends StatelessWidget {
  const FavoritePlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          color: const Color(0xFFE8ECF4),
          child: Padding(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeHeader(title: 'Saved Places'.tr),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'My Favorite Destinations'.tr,
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
                                .collection('favoritePlaces')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('places')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final List<DocumentSnapshot> documents =
                                    snapshot.data!.docs;
                                log(documents.length.toString());
                                return documents.isEmpty
                                    ? Center(
                                        child: Text('No Favorite Places'.tr))
                                    : ListView(
                                        children: documents
                                            .map((doc) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SavedPlaceWidget(
                                                    cityname: doc['cityName'],
                                                    placeDescription:
                                                        doc['placeDescription'],
                                                    placeImage1:
                                                        doc['placeImage1'],
                                                    placeImage2:
                                                        doc['placeImage2'],
                                                    placeName:
                                                        doc['placeName'])))
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
