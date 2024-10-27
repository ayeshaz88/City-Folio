// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PlaceRequestDetailsScreen extends StatefulWidget {
  final String documentId;

  const PlaceRequestDetailsScreen({
    Key? key,
    required this.documentId,
    required Null Function(Map<String, dynamic> acceptedData)
        updatePlacePortfolio,
    required List documentIds,
    required BuildContext context,
    required QueryDocumentSnapshot<Object?> document,
  }) : super(key: key);

  @override
  _PlaceRequestDetailsScreenState createState() =>
      _PlaceRequestDetailsScreenState();
}

class _PlaceRequestDetailsScreenState extends State<PlaceRequestDetailsScreen> {
  late TextEditingController _place_nameController;
  late TextEditingController _place_locationController;
  late TextEditingController _place_detailController;
  PickedFile? _newImageFile;
  PickedFile? _newImageFile2;
  String? _image1_url;
  String? _image2_url;

  @override
  void initState() {
    super.initState();
    _place_nameController = TextEditingController();
    _place_locationController = TextEditingController();
    _place_detailController = TextEditingController();
    _fetchPlaceDetails();
  }

  Future<void> _fetchPlaceDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('suggestPlace')
          .doc(widget.documentId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> placeData = snapshot.data()!;
        _place_nameController.text = placeData['place_name'] ?? '';
        _place_locationController.text = placeData['place_location'] ?? '';
        _place_detailController.text = placeData['place_detail'] ?? '';
        _image1_url = placeData['image1_url'];
        _image2_url = placeData['image2_url'];

        setState(() {}); // Update the UI with fetched data
      }
    } catch (error) {
      print('Error fetching place details: $error'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Suggestion'.tr),
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
                  : _image1_url != null
                      ? ClipOval(
                          child: Image.network(
                            _image1_url!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.photo_camera),
            ),
          ),
          TextFormField(
            controller: _place_nameController,
            decoration: InputDecoration(labelText: 'Place Name'.tr),
          ),
          TextFormField(
            controller: _place_locationController,
            decoration: InputDecoration(labelText: 'Place Location'.tr),
          ),
          TextFormField(
            controller: _place_detailController,
            decoration: InputDecoration(labelText: 'Place Detail'.tr),
          ),
          const SizedBox(height: 20),
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
                  : _image2_url != null
                      ? Container(
                          child: Image.network(
                            _image2_url!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.photo_camera),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Accept the place suggestion
                  acceptPlaceSuggestion();
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
      ),
    );
  }

  Future<void> _pickImage(int i) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _newImageFile = pickedImage as PickedFile?;
      });
    }
  }

  Future<String> uploadImageToStorage(PickedFile newImageFile) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('place_images/${DateTime.now().toString()}');
      await storageRef.putFile(File(newImageFile.path));
      return await storageRef.getDownloadURL();
    } catch (error) {
      print('Error uploading image: $error'.tr);
      return '';
    }
  }

  void acceptPlaceSuggestion() async {
    try {
      await FirebaseFirestore.instance.collection('AcceptPlace').add({
        'place_name': _place_nameController.text,
        'place_location': _place_locationController.text,
        'place_detail': _place_detailController.text,
        'image1_url': _image1_url,
        'image2_url': _image2_url,
      });
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text('Place suggestion accepted successfully!'.tr),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context); // Close the screen
    } catch (error) {
      print('Error accepting place suggestion: $error'.tr);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to accept place suggestion'.tr),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
