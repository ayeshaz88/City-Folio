import 'package:city_folio/Widgets/HomeScreenWidgets/BusinessDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessWidget extends StatelessWidget {
  final String documentId;

  const BusinessWidget({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Business Details'.tr),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('businessfolio')
            .doc(documentId) // Query specific document by ID
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'.tr),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('Document does not exist'.tr),
            );
          }

          // Extract data from the document
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return BusinessDetails(
            documentId: documentId,
            image1_url: data['image1_url'] ?? '',
            image2_url: data['image2_url'] ?? '',
            business_name: data['business_name'] ?? '',
            business_detail: data['business_detail'] ?? '',
            business_location: data['business_location'] ?? '',
          );
        },
      ),
    );
  }
}
