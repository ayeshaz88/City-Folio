// ignore_for_file: file_names
import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/screens/fade_animationtest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfileUpdateForm extends StatefulWidget {
  const ProfileUpdateForm({Key? key});

  @override
  State<ProfileUpdateForm> createState() => _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends State<ProfileUpdateForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isLoader = false;

  Future<bool> checkIfEmailExists(String email) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: "dummyPassword", // Provide a dummy password for sign-in attempt
      );
      return true; // Email is registered
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found'.tr) {
        return false; // Email is not registered
      }
      throw e; // Other errors
    }
  }

  Future<void> updatePassword(String email, String password) async {
    try {
      // Sign in user with email and current password to verify credentials
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: currentPassController.text,
      );

      // Update user's password
      await FirebaseAuth.instance.currentUser!.updatePassword(password);

      // Password updated successfully, show success message
      Fluttertoast.showToast(msg: 'Password updated successfully!'.tr);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password'.tr) {
        Fluttertoast.showToast(msg: 'Incorrect current password.'.tr);
      } else {
        // Handle other FirebaseAuthExceptions
        Fluttertoast.showToast(msg: 'Failed to update password. Please try again.'.tr);
      }
    } catch (e) {
      // Handle other exceptions
      Fluttertoast.showToast(msg: 'Failed to update password. Please try again.'.tr);
    }
  }

  final formKey = GlobalKey<FormState>();

  Future saveData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'userID': FirebaseAuth.instance.currentUser!.uid,
      'userEmail ': emailController.text.toString(),

      'isApproved': false,
    }).whenComplete(
          () => Get.to(const ProfileUpdateForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            height: Get.height * 0.55,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 30.0,
                  offset: const Offset(5.0, 5.0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: contentPadding,
                    child: Column(
                      children: [
                        FadeInAnimation(
                          delay: 1.8,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              label: Text('Email'.tr),
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email address.".tr;
                              } else if (!RegExp(
                                  r'^([a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$)')
                                  .hasMatch(value)) {
                                return "Invalid email format.".tr;
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.1,
                          child: TextFormField(
                            obscureText: true,
                            controller: currentPassController,
                            decoration: InputDecoration(
                              label: Text('Current Password'.tr),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your current password.".tr;
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.1,
                          child: TextFormField(
                            obscureText: true,
                            controller: newPassController,
                            decoration: InputDecoration(
                              label: Text('New Password'.tr),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a new password.".tr;
                              } else if (value.length < 8 &&
                                  value.toString() != 'admin') {
                                return "Password must be at least 8 characters long.".tr;
                              } else if (!RegExp(
                                  r'^((?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).*$)')
                                  .hasMatch(value)) {
                                return "Password must contain uppercase, lowercase, and digits.".tr;
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.1,
                          child: TextFormField(
                            obscureText: true,
                            controller: confirmPassController,
                            decoration: InputDecoration(
                              label: Text('Confirm New Password'.tr),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please confirm your password.".tr;
                              } else if (value != newPassController.text) {
                                return "Passwords do not match.".tr;
                              }
                              return null;
                            },
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validate the form
                              if (formKey.currentState!.validate()) {
                                // Check if the email is registered
                                bool emailExists = await checkIfEmailExists(emailController.text);
                                if (!emailExists) {
                                  Fluttertoast.showToast(msg: 'This email is not registered.'.tr);
                                  return;
                                }

                                // Email is registered, update password
                                await updatePassword(emailController.text, newPassController.text);
                              }
                            },
                            child: Text('Update Password'.tr),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
