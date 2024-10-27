import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePageButtonNavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const HomePageButtonNavigationBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          label: "Explore".tr,
          icon: Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          label: "Map".tr,
          icon: Icon(Icons.location_on),
        ),
        BottomNavigationBarItem(
          label: "Ticket".tr,
          icon: Icon(FontAwesomeIcons.ticket),
        ),
        BottomNavigationBarItem(
          label: "User".tr,
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
