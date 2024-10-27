// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BusinessRequestDetailsScreen extends StatefulWidget {
  final String documentId;

  const BusinessRequestDetailsScreen({
    Key? key,
    required this.documentId,
    required void Function(Map<String, dynamic> acceptedData)
        updateBusinessPortfolio,
    required List documentIds,
    required BuildContext context,
    required QueryDocumentSnapshot<Object?> document,
  }) : super(key: key);

  @override
  _BusinessRequestDetailsScreenState createState() =>
      _BusinessRequestDetailsScreenState();
}

class _BusinessRequestDetailsScreenState
    extends State<BusinessRequestDetailsScreen> {
  late TextEditingController _businessNameController;
  late TextEditingController _businessLocationController;
  late TextEditingController _businessDetailController;
  PickedFile? _newImageFile;
  PickedFile? _newImageFile2;
  String? _image1Url;
  String? _image2Url;

  @override
  void initState() {
    super.initState();
    _businessNameController = TextEditingController(text: '');
    _businessLocationController = TextEditingController(text: '');
    _businessDetailController = TextEditingController(text: '');
  }

  Future<void> _pickImage(int imageNumber) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        if (imageNumber == 1) {
          _newImageFile = pickedImage as PickedFile?;
        }
        if (imageNumber == 2) {
          _newImageFile = pickedImage as PickedFile?;
        } else {}
      });
    }
  }

  Future<String> uploadImageToStorage(PickedFile newImageFile) async {
    try {
      // Get a reference to the Firebase Storage
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('business_images/${DateTime.now().toString()}');

      // Upload the image file to Firebase Storage
      await storageRef.putFile(File(newImageFile.path));

      // Get the download URL of the uploaded image
      String imageUrl = await storageRef.getDownloadURL();

      // Return the download URL
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e'.tr);
      return ''; // Return an empty string or handle the error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Business Requests'.tr),
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
                .collection('businessportfolio')
                .doc(widget.documentId)
                .get(),
            builder: (context, snapshot) {
              print("Document ID: ${widget.documentId}");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                if (kDebugMode) {
                  print('Error fetching document: ${snapshot.error}');
                }
                return Text('Error fetching document: ${snapshot.error}');
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Text('Document does not exist');
              }

              Map<String, dynamic> businessData =
                  snapshot.data!.data() as Map<String, dynamic>;

              _businessNameController.text =
                  businessData['business_name'] ?? '';
              _businessLocationController.text =
                  businessData['business_location'] ?? '';
              _businessDetailController.text =
                  businessData['business_detail'] ?? '';
              _image1Url = businessData['image1_url'];
              _image2Url = businessData['image2_url'];

              return Column(
                children: [
                  Text('Document ID: ${widget.documentId}'.tr),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _pickImage(1),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: _newImageFile != null
                          ? ClipOval(
                              child: Image.file(
                                File(_newImageFile!.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : _image1Url != null
                              ? ClipOval(
                                  child: Image.network(
                                    _image1Url!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(Icons.photo_camera),
                    ),
                  ),
                  TextFormField(
                    controller: _businessNameController,
                    decoration:
                        InputDecoration(labelText: 'Business Name:'.tr),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _businessLocationController,
                    decoration:
                        InputDecoration(labelText: 'Business Location:'.tr),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _businessDetailController,
                    decoration: InputDecoration(labelText: 'Business Detail:'.tr),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => _pickImage(2),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: _newImageFile2 != null
                          ? Container(
                              child: Image.file(
                                File(_newImageFile2!.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : _image2Url != null
                              ? Container(
                                  child: Image.network(
                                    _image2Url!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(Icons.photo_camera),
                    ),
                  ),
                  SizedBox(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Continue with the rest of your acceptance logic
                          Map<String, dynamic> newBusinessData = {
                            'pictureUrl': _image1Url,
                            'companyName': _businessNameController.text,
                            'companyLogoUrl': _image2Url,
                            'pricing': '...',
                            'companyDetail': _businessDetailController.text,
                            'address': _businessLocationController.text,
                          };
                          // Call your function to create a business card
                          createBusinessCard(newBusinessData);
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

  void createBusinessCard(Map<String, dynamic> newBusinessData) async {
    try {
      // Save the edited data to the 'AcceptBusiness' collection
      DocumentReference acceptBusinessDoc =
          await FirebaseFirestore.instance.collection('AcceptBusiness').add({
        'businessName': newBusinessData['companyName'],
        'businessLocation': newBusinessData['address'],
        'businessDetail': newBusinessData['companyDetail'],
        'image1_url': newBusinessData['pictureUrl'],
        'image2_url': newBusinessData['companyLogoUrl'],
      });

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Business accepted successfully!'.tr),
          duration: Duration(seconds: 2),
        ),
      );

      // Close the current screen
      Navigator.pop(context);
    } catch (error) {
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error accepting business: $error'.tr),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
