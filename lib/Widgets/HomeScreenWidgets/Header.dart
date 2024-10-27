import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  final String title;
  HomeHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff312dA4),
    automaticallyImplyLeading:
          false, // Show the leading back button if navigation is available
      title: Text(
        title.tr,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
      // Add other AppBar properties as needed
    );
  }
}
