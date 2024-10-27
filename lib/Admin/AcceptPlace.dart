// ignore_for_file: recursive_getters

import 'package:city_folio/Admin/PlaceDetailScreen.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/Header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HomeHeader(title: 'Suggested Places'.tr),
      ),
      body: _buildAcceptPlace(context),
    );
  }

  Widget _buildAcceptPlace(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('AcceptPlace').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'.tr));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No data available'.tr));
        }

        // If data is available, build the UI
        return ListView(
          padding: EdgeInsets.all(16),
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> PlaceData = doc.data() as Map<String, dynamic>;

            // Extract business details
            String place_detail = PlaceData['place_detail'] ?? '';
            String place_location = PlaceData['place_location'] ?? '';
            String place_name = PlaceData['place_name'] ?? '';
            String image1_url = PlaceData['image1_url'] ?? '';
            String image2_url = PlaceData['image2_url'] ?? '';

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // Navigate to PlaceDetailScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailScreen(
                        place_name:
                            place_name, // Pass the actual value of place_name from PlaceData
                        place_detail: place_detail,
                        place_location: place_location,
                        image1_url:
                            image1_url, // Pass the actual value of place_detail from PlaceData
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.network(
                          image1_url,
                          height: 100.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(image2_url),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              place_name.tr,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          place_detail.tr,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          place_location.tr,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
