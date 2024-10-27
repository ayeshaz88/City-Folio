// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobForm extends StatefulWidget {
  const JobForm({Key? key}) : super(key: key);

  @override
  State<JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  final _formKey = GlobalKey<FormState>();
  final _postnameController = TextEditingController();
  final _locationController = TextEditingController();
  final _skillsController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool isLoader = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      try {
        // Upload images to Firebase Storage

        // Save form data to Firestore
        await FirebaseFirestore.instance.collection('jobfolio').add({
          'post_name': _postnameController.text,
          'jobs_skills': _skillsController.text,
          'job_location': _locationController.text,
          'job_description': _descriptionController.text,
          'timestamp': DateTime.now(),
        });

        // Reset form fields and images after successful submission
        _postnameController.clear();
        _skillsController.clear();
        _descriptionController.clear();

        // Show success message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Form submitted successfully!'.tr),
        ));
      } catch (error) {
        // Handle errors
        print('Error submitting form: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error submitting form. Please try again later.'.tr),
        ));
      } finally {
        setState(() {
          isLoader = false;
        });
      }
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
                TextFormField(
                  controller: _postnameController,
                  decoration:
                  InputDecoration(labelText: 'Post Available'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Post Available.'.tr;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Job Location'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Job location.'.tr;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _skillsController,
                  decoration: InputDecoration(labelText: 'Skills Required'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Skills Required.'.tr;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Job Description'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Job Description.'.tr;
                    }
                    return null;
                  },
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
