import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:city_folio/screens/adminlogin.dart';
import 'package:city_folio/screens/fade_animationtest.dart';
import 'package:city_folio/screens/signup_page.dart';
import 'package:city_folio/common/common.dart';
import 'package:city_folio/Widgets/custom_widget.dart';
import 'login_page.dart';

class AuthenticationUI extends StatefulWidget {
  const AuthenticationUI({super.key});

  @override
  State<AuthenticationUI> createState() => _AuthenticationUIState();
}

class _AuthenticationUIState extends State<AuthenticationUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/imag.jpg",
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              )
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  FadeInAnimation(
                    delay: 2,
                    child: CustomElevatedButton(
                      message: 'login'.tr,
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInAnimation(
                    delay: 2.5,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupPage()));
                      },
                      style: ButtonStyle(
                        side: const MaterialStatePropertyAll(
                            BorderSide(color: Colors.black)
                        ),
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        fixedSize: const MaterialStatePropertyAll(
                            Size.fromWidth(370)
                        ),
                        padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 20),
                        ),
                        backgroundColor: const MaterialStatePropertyAll(
                            Colors.white
                        ),
                      ),
                      child: Text(
                        'register'.tr,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Urbanist-SemiBold",
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  FadeInAnimation(
                    delay: 2.5,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdminLogin()));
                      },
                      child: Text('admin_login'.tr, style: Common().mediumTheme),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
