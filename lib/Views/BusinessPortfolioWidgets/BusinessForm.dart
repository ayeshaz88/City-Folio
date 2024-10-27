// ignore: file_names
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BusinessForm extends StatefulWidget {
  const BusinessForm({Key? key}) : super(key: key);

  @override
  State<BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _detailController = TextEditingController();

  File? _image1;
  File? _image2;

  bool isLoader = false;

  // Function to handle image picking
  Future<void> _pickImage(int imageNumber) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    ); // Use ImageSource.camera for camera

    if (pickedImage != null) {
      setState(() {
        if (imageNumber == 1) {
          _image1 = File(pickedImage.path);
        } else {
          _image2 = File(pickedImage.path);
        }
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _image1 != null &&
        _image2 != null) {
      setState(() {
        isLoader = true;
      });

      try {
        // Upload images to Firebase Storage
        final image1Ref = FirebaseStorage.instance
            .ref()
            .child('images')
            .child('image1_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await image1Ref.putFile(_image1!);
        final image2Ref = FirebaseStorage.instance
            .ref()
            .child('images')
            .child('image2_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await image2Ref.putFile(_image2!);

        // Retrieve download URLs of the uploaded images
        final image1Url = await image1Ref.getDownloadURL();
        final image2Url = await image2Ref.getDownloadURL();

        // Save form data to Firestore
        await FirebaseFirestore.instance.collection('businessportfolio').add({
          'business_name': _nameController.text,
          'business_location': _locationController.text,
          'business_detail': _detailController.text,
          'timestamp': DateTime.now(),
          'image1_url': image1Url,
          'image2_url': image2Url,
        });

        // Reset form fields and images after successful submission
        _nameController.clear();
        _locationController.clear();
        _detailController.clear();
        _image1 = null;
        _image2 = null;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Form submitted successfully!'.tr),
        ));
      } catch (error) {
        // Handle errors
        print('Error submitting form: $error'.tr);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error submitting form. Please try again later.'.tr),
        ));
      } finally {
        setState(() {
          isLoader = false;
        });
      }
    } else {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields and upload both images.'.tr),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => _pickImage(1),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: _image1 != null
                        ? ClipOval(
                            child: Image.file(
                              _image1!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(Icons.add_a_photo),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Business Name'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Business Name.'.tr;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Business Location'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Business Location.'.tr;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _detailController,
                  decoration: InputDecoration(labelText: 'Business Detail'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Business Detail.'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _image2 != null
                    ? Image.file(
                        _image2!,
                        height: 100,
                      )
                    : ElevatedButton(
                        onPressed: () => _pickImage(2),
                        child: Text('Upload Image'.tr),
                      ),
                const SizedBox(height: 16),
                isLoader
                    ? const LinearProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Submit'.tr),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
