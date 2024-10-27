// ignore_for_file: file_names

import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Constants/assets_location.dart';
import 'package:city_folio/Utils/colors.dart';
import 'package:city_folio/placeDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CityWidget extends StatefulWidget {
  String placeImage1, placeImage2, cityname, placeName, placeDescription;
  CityWidget(
      {super.key,
      required this.cityname,
      required this.placeDescription,
      required this.placeImage1,
      required this.placeImage2,
      required this.placeName});

  @override
  State<CityWidget> createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {
  void deleteDocumentByField(String fieldName, String value) async {
    // Replace 'your_collection' with your Firestore collection name
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favoritePlaces');

    try {
      // Query to find the document(s) with the specified field value
      QuerySnapshot querySnapshot =
          await collectionReference.where(fieldName, isEqualTo: value).get();

      // Delete each document found by the query
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await collectionReference.doc(documentSnapshot.id).delete();
        Fluttertoast.showToast(msg: 'Document deleted successfully!'.tr);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Document deleted successfully! $e'.tr);
    }
  }

  bool _isFav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PlaceDetails(
              cityname: widget.cityname,
              placeDescription: widget.placeDescription,
              placeImage1: widget.placeImage1,
              placeImage2: widget.placeImage2,
              placeName: widget.placeName,
            ));
      },
      child: Container(
        height: Get.height * 0.2,
        width: Get.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 30.0,
              offset: const Offset(5.0, 5.0),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Get.height * 0.15,
              width: Get.width,
              child: Stack(
                children: [
                  Image.network(
                    widget.placeImage1,
                    fit: BoxFit.cover,
                    height: Get.height * 0.15,
                    width: Get.width,
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        if (!_isFav) {
                          await FirebaseFirestore.instance
                              .collection('favoritePlaces')
                              .doc(FirebaseAuth.instance.currentUser!.uid
                                  .toString())
                              .collection('places')
                              .doc(widget.placeName)
                              .set({
                            'cityName': widget.cityname,
                            'placeName': widget.placeName,
                            'placeImage1': widget.placeImage1,
                            'placeImage2': widget.placeImage2,
                            'placeDescription': widget.placeDescription,
                          }).whenComplete(() => Fluttertoast.showToast(
                                  msg: 'Place added into the Favorites'.tr));
                        }
                        if (_isFav) {
                          await FirebaseFirestore.instance
                              .collection('favoritePlaces')
                              .doc(FirebaseAuth.instance.currentUser!.uid
                                  .toString())
                              .collection('places')
                              .doc(widget.placeName)
                              .delete()
                              .whenComplete(() => Fluttertoast.showToast(
                                  msg: 'Place removed from Favorites'.tr));
                        }

                        setState(() {
                          if (_isFav == false) {
                            _isFav = true;
                          } else {
                            _isFav = false;
                          }
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: AppColors().sec_color,
                        child: Center(
                          child: SvgPicture.asset(
                            _isFav
                                ? 'assets/svgs/bookmark 1.svg'
                                : Assets.bookmarkSvg,
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    widget.placeName,
                    style: headerText.copyWith(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
