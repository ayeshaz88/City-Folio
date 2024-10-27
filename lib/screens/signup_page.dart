import 'package:city_folio/Views/HomeScreen.dart';
import 'package:city_folio/Widgets/custom_widget.dart';
import 'package:city_folio/common/common.dart';
import 'package:city_folio/screens/authentication_ui.dart';
import 'package:city_folio/screens/fade_animationtest.dart';
import 'package:city_folio/screens/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  late String email, password, name;
  bool isLoader = false;

  Future registerUser(String email, String pass) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passController.text.toString());
    return user;
  }

  final formKey = GlobalKey<FormState>();

  Future saveData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'userID': FirebaseAuth.instance.currentUser!.uid,
      'userEmail ': emailController.text.toString(),
      'userName': nameController.text.toString(),
      'isApproved': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(232, 236, 244, 1),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInAnimation(
                    delay: 0.6,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AuthenticationUI()));
                        },
                        icon: const Icon(
                          CupertinoIcons.back,
                          size: 35,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInAnimation(
                          delay: 0.9,
                          child: Text(
                            "Hello! Register to get".tr,
                            style: Common().titelTheme,
                          ),
                        ),
                        FadeInAnimation(
                          delay: 1.2,
                          child: Text(
                            "started".tr,
                            style: Common().titelTheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      child: Column(
                        children: [
                          FadeInAnimation(
                            delay: 1.5,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  label: Text('User Name'.tr),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a username.".tr;
                                } else if (!RegExp(r'^[A-Z][a-z]*$')
                                    .hasMatch(value)) {
                                  return "Username should start with a capital letter and only contain alphabets.".tr;
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeInAnimation(
                            delay: 1.8,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  label: Text('Email'.tr),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                  )),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeInAnimation(
                            delay: 2.1,
                            child: TextFormField(
                              obscureText: true,
                              controller: passController,
                              decoration: InputDecoration(
                                  label: Text('Password'.tr),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a password.".tr;
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeInAnimation(
                            delay: 2.4,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  label: Text('Confirm Password'.tr),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your password.".tr;
                                } else if (value != passController.text) {
                                  return "Passwords do not match.".tr;
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeInAnimation(
                            delay: 2.7,
                            child: CustomElevatedButton(
                              message: "Register".tr,
                              function: () async {
                                // Get email and password from controllers
                                try {
                                  // Create a new user with email and password
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: emailController.text.toString(),
                                    password: passController.text.toString(),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Account created successfully!'.tr),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                  // If registration is successful, navigate to HomeScreen
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                } catch (error) {
                                  // Handle registration errors
                                  if (error is FirebaseAuthException &&
                                      error.code == 'email-already-in-use'.tr) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Email is already registered. Please log in.".tr,
                                      timeInSecForIosWeb: 3,
                                    );


                                    // Navigate to the login page
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  } else {
                                    // Handle other registration errors
                                    Fluttertoast.showToast(
                                      msg:
                                          "Registration failed. Please try again.".tr,
                                      timeInSecForIosWeb: 3,
                                    );
                                  }
                                }
                              },
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          FadeInAnimation(
                            delay: 2.4,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, right: 15, left: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  FadeInAnimation(
                    delay: 3.6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?".tr,
                            style: Common().hinttext,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                              },
                              child: Text(
                                "Login here".tr,
                                style: Common().mediumTheme,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
