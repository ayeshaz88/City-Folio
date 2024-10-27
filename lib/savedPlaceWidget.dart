// ignore_for_file: file_names

import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Utils/colors.dart';
import 'package:city_folio/placeDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SavedPlaceWidget extends StatefulWidget {
  final String placeImage1, placeImage2, cityname, placeName, placeDescription;

  SavedPlaceWidget({
    Key? key,
    required this.cityname,
    required this.placeDescription,
    required this.placeImage1,
    required this.placeImage2,
    required this.placeName,
  }) : super(key: key);

  @override
  State<SavedPlaceWidget> createState() => _SavedPlaceWidgetState();
}

class _SavedPlaceWidgetState extends State<SavedPlaceWidget> {
  bool _isFav = false; // Initialize to false initially

  @override
  void initState() {
    super.initState();
    // Check if the place is already a favorite and update _isFav accordingly
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    try {
      DocumentSnapshot favoriteSnapshot = await FirebaseFirestore.instance
          .collection('favoritePlaces')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('places')
          .doc(widget.placeName)
          .get();

      setState(() {
        _isFav = favoriteSnapshot.exists; // Update _isFav based on snapshot
      });
    } catch (error) {
      print('Error checking favorite status: $error'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the PlaceDetails screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetails(
              cityname: widget.cityname,
              placeDescription: widget.placeDescription,
              placeImage1: widget.placeImage1,
              placeImage2: widget.placeImage2,
              placeName: widget.placeName,
            ),
          ),
        );
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
                        // Toggle the favorite status
                        await _toggleFavoriteStatus();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: AppColors().sec_color,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/svgs/bookmark 1.svg',
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
                    widget.placeName.tr,
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

  Future<void> _toggleFavoriteStatus() async {
    try {
      if (_isFav) {
        // Remove the place from favorites
        await FirebaseFirestore.instance
            .collection('favoritePlaces')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('places')
            .doc(widget.placeName)
            .delete();

        Fluttertoast.showToast(msg: 'Place removed from Favorites');
      } else {
        // Add the place to favorites
        await FirebaseFirestore.instance
            .collection('favoritePlaces')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('places')
            .doc(widget.placeName)
            .set({
          'cityName': widget.cityname,
          'placeName': widget.placeName,
          'placeImage1': widget.placeImage1,
          'placeImage2': widget.placeImage2,
          'placeDescription': widget.placeDescription,
        });

        Fluttertoast.showToast(msg: 'Place added to Favorites'.tr);
      }

      // Update the favorite status
      setState(() {
        _isFav = !_isFav;
      });
    } catch (error) {
      Fluttertoast.showToast(msg: 'Failed to toggle favorite status'.tr);
      print('Error toggling favorite status: $error'.tr);
    }
  }
}
