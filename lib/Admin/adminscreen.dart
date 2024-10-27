// ignore_for_file: use_build_context_synchronously

import 'package:city_folio/Admin/BusinessRequest.dart';
import 'package:city_folio/Admin/JobRequest.dart';
import 'package:city_folio/Admin/PlaceSuggest.dart';
import 'package:city_folio/screens/authentication_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  DateTime? currentBackPressTime;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false; // Always return false to prevent app from closing
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Admin Panel'.tr),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  // Navigate to authentication UI screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthenticationUI(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 08),
              GestureDetector(
                onTap: () {
                  _navigateToList('businessportfolio', 'Business Requests');
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Business Requests'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10), // Add spacing between buttons and text
              GestureDetector(
                onTap: () {
                  _navigateToList('jobfolio', 'Job Requests');
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Job Requests'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10), // Add spacing between text and buttons
              GestureDetector(
                onTap: () {
                  _navigateToList('suggestPlace', 'Place Suggestions');
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Place Suggestions'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _navigateToList(String collection, String title) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collection).get();

      if (querySnapshot.docs.isNotEmpty) {
        if (collection == 'businessportfolio') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessListScreen(
                documents: querySnapshot.docs,
                title: title,
              ),
            ),
          );
        } else if (collection == 'suggestPlace') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceListScreen(
                documents: querySnapshot.docs,
                title: title,
              ),
            ),
          );
        } else if (collection == 'jobfolio') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobListScreen(
                documents: querySnapshot.docs,
                title: title,
              ),
            ),
          );
        }
      } else {
        print('No $title found.');
      }
    } catch (error) {
      print('Error fetching $title: $error');
    }
  }
}

class ListScreen extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final String title;

  const ListScreen({Key? key, required this.documents, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          var document = documents[index].data() as Map<String, dynamic>;
          return ListTile(
            title: Text(document['business_name'.tr] ?? ''),
            subtitle: Text(document['business_location'.tr] ?? ''),
            onTap: () {
              String documentId = documents[index].id;
              // Navigate to BusinessRequestDetailsScreen
              // Pass the necessary data to BusinessRequestDetailsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusinessRequestDetailsScreen(
                    documentId: documentId,
                    updateBusinessPortfolio:
                        (Map<String, dynamic> acceptedData) {
                      // Implement the logic to update the business portfolio here
                      // You might need to use setState or another mechanism to trigger the update
                    },
                    documentIds: const [], // Pass the necessary document IDs
                    context: context,
                    document: documents[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BusinessListScreen extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final String title;

  const BusinessListScreen({
    Key? key,
    required this.documents,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          var document = documents[index].data() as Map<String, dynamic>;
          return ListTile(
            title: Text(document['business_name'.tr] ?? ''),
            subtitle: Text(document['business_location'.tr] ?? ''),
            onTap: () {
              String documentId = documents[index].id;
              // Navigate to BusinessRequestDetailsScreen
              // Pass the necessary data to BusinessRequestDetailsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusinessRequestDetailsScreen(
                    documentId: documentId,
                    updateBusinessPortfolio:
                        (Map<String, dynamic> acceptedData) {
                      // Implement the logic to update the business portfolio here
                      // You might need to use setState or another mechanism to trigger the update
                    },
                    documentIds: const [], // Pass the necessary document IDs
                    context: context,
                    document: documents[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PlaceListScreen extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final String title;

  const PlaceListScreen({
    Key? key,
    required this.documents,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          var document = documents[index].data() as Map<String, dynamic>;
          return ListTile(
            title: Text(document['place_name'.tr] ?? ''),
            subtitle: Text(document['place_location'.tr] ?? ''),
            onTap: () {
              String documentId = documents[index].id;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceRequestDetailsScreen(
                    documentId: documentId,
                    updatePlacePortfolio: (Map<String, dynamic> acceptedData) {
                      // Implement the logic to update the business portfolio here
                      // You might need to use setState or another mechanism to trigger the update
                    },
                    documentIds: const [], // Pass the necessary document IDs
                    context: context,
                    document: documents[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class JobListScreen extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final String title;

  const JobListScreen({
    Key? key,
    required this.documents,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          var document = documents[index].data() as Map<String, dynamic>;
          return ListTile(
            title: Text(document['post_name'.tr] ?? ''),
            subtitle: Text(document['job_location'.tr] ?? ''),
            onTap: () {
              String documentId = documents[index].id;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobRequestDetailsScreen(
                    documentId: documentId,
                    updatePlacePortfolio: (Map<String, dynamic> acceptedData) {
                      // Implement the logic to update the business portfolio here
                      // You might need to use setState or another mechanism to trigger the update
                    },
                    documentIds: const [], // Pass the necessary document IDs
                    context: context,
                    document: documents[index],
                    updateJobPortfolio: (Map<String, dynamic> acceptedData) {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
