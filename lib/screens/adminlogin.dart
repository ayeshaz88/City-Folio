import 'package:city_folio/Admin/adminscreen.dart';
import 'package:city_folio/Widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    // Check if user is admin and password is admin
    if (_userController.text.trim().toLowerCase() == 'admin' &&
        _passwordController.text.trim() == 'admin') {
      // If admin credentials, proceed with login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AdminScreen(),
        ),
      );
    } else {
      // Show error message for invalid credentials
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'.tr),
          content: Text('Invalid credentials. Please try again.'.tr),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'.tr),
            ),
          ],
        ),
      );
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
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Admin!".tr,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "See New Request!".tr,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
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
                        TextFormField(
                          controller: _userController,
                          decoration: InputDecoration(
                            labelText: 'User'.tr,
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password'.tr,
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomElevatedButton(
                          message: 'Login'.tr,
                          function: login,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
