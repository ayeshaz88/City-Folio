import 'package:city_folio/Widgets/HomeScreenWidgets/JobDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobWidget extends StatelessWidget {
  final String documentId;

  const JobWidget({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Job Details'.tr),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('jobwidget')
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

          return JobDetails(
            documentId: documentId,
            post_name: data['post_name'] ?? '',
            job_location: data['job_location'] ?? '',
            jobs_skills: data['jobs_skills'] ?? '',
            job_description: data['job_description'] ?? '',
            job_email: data['job_email'],
          );
        },
      ),
    );
  }
}
