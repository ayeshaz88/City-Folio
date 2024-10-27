// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobRequestDetailsScreen extends StatefulWidget {
  final String documentId;

  const JobRequestDetailsScreen({
    Key? key,
    required this.documentId,
    required void Function(Map<String, dynamic> acceptedData)
        updateJobPortfolio,
    required List documentIds,
    required BuildContext context,
    required QueryDocumentSnapshot<Object?> document,
    required Null Function(Map<String, dynamic> acceptedData)
        updatePlacePortfolio,
  }) : super(key: key);

  @override
  _JobRequestDetailsScreenState createState() =>
      _JobRequestDetailsScreenState();
}

class _JobRequestDetailsScreenState extends State<JobRequestDetailsScreen> {
  late TextEditingController _postnameController;
  late TextEditingController _joblocationController;
  late TextEditingController _skillsController;
  late TextEditingController _descriptionController;

  String? post_name;
  String? job_location;
  String? jobs_skills;
  String? job_description;

  @override
  void initState() {
    super.initState();
    _postnameController = TextEditingController(); // Initialize the controller
    _joblocationController =
        TextEditingController(); // Initialize the controller
    _skillsController = TextEditingController(); // Initialize the controller
    _descriptionController = TextEditingController();

    post_name = _postnameController.text;
    job_location = _joblocationController.text;
    jobs_skills = _skillsController.text;
    job_description = _descriptionController.text; // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Jobs Requests'.tr),
      ),
      body: _buildEditScreen(),
    );
  }

  Widget _buildEditScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('jobfolio')
                .doc(widget.documentId)
                .get(),
            builder: (context, snapshot) {
              print("Document ID: ${widget.documentId}".tr);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                if (kDebugMode) {
                  print('Error fetching document: ${snapshot.error}'.tr);
                }
                return Text('Error fetching document: ${snapshot.error}'.tr);
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Text('Document does not exist'.tr);
              }

              Map<String, dynamic> JobData =
                  snapshot.data!.data() as Map<String, dynamic>;

              _postnameController.text = JobData['post_name'] ?? '';
              _joblocationController.text = JobData['job_location'] ?? '';
              _skillsController.text = JobData['jobs_skills'] ?? '';
              _descriptionController.text = JobData['job_description'] ?? '';

              return Column(
                children: [
                  Text('Document ID: ${widget.documentId}'.tr),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _postnameController,
                    decoration: InputDecoration(
                        labelText: 'Post Available: $post_name'.tr),
                  ),
                  TextFormField(
                    controller: _skillsController,
                    decoration:
                        InputDecoration(labelText: 'Jobs Skills: $jobs_skills'.tr),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _joblocationController,
                    decoration: InputDecoration(
                        labelText: 'Job Location: $job_location'.tr),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        labelText: 'Business Detail: $job_description'.tr),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Continue with the rest of your acceptance logic
                          Map<String, dynamic> newJobData = {
                            'companyName': _postnameController.text,
                            'pricing': '...',
                            'companyDetail': _descriptionController.text, // Fix
                            'address': _joblocationController.text,
                            'skills': _skillsController.text,
                          };
                          // Call your function to create a business card
                          acceptJob(
                              newJobData); // Call your accept job function
                        },
                        child: Text('Accept'.tr),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Reject'.tr),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void acceptJob(Map<String, dynamic> newJobData) async {
    try {
      // Save the accepted job data to the 'AcceptJobs' collection
      DocumentReference acceptJobsDoc =
          await FirebaseFirestore.instance.collection('AcceptJobs').add({
        'post_name': newJobData['companyName'],
        'job_location': newJobData['address'],
        'jobs_skills': newJobData['skills'], // Corrected field name
        'job_description': newJobData['companyDetail'], // Corrected field name
      });

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Job accepted successfully!'.tr),
          duration: Duration(seconds: 2),
        ),
      );

      // Close the current screen
      Navigator.pop(context);
    } catch (error) {
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error accepting job: $error'.tr),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
