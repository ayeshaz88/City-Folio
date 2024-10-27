import 'package:city_folio/Views/HomeScreen.dart';
import 'package:city_folio/Widgets/custom_widget.dart';
import 'package:city_folio/common/common.dart';
import 'package:city_folio/screens/fade_animationtest.dart';
import 'package:city_folio/screens/forget_password.dart';
import 'package:city_folio/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    try {
      // Sign in the user with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Navigate to the home screen after successful login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (error) {
      // Handle login errors
      print('Login error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECF4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back! Glad".tr,
                        style: Common().titelTheme,
                      ),
                      Text(
                        "to see you, Again!".tr,
                        style: Common().titelTheme,
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
                          delay: 1.8,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                label: Text('Email'.tr),
                                prefixIcon: Icon(
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
                            controller: _passwordController,
                            decoration: InputDecoration(
                                label: Text('Password'.tr),
                                prefixIcon: Icon(
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
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ForgetPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?'.tr,
                              style: Common().semiboldblack,
                            ),
                          ),
                        ),
                        CustomElevatedButton(
                          message: 'Login'.tr,
                          function: login,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?'.tr,
                        style: Common().hinttext,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Register Now'.tr,
                          style: Common().mediumTheme,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
