import 'package:city_folio/Views/BusinessPortfolio.dart';
import 'package:city_folio/Views/Event/home_page.dart';
import 'package:city_folio/Views/SelectCity.dart';
import 'package:city_folio/Views/Settings.dart';
import 'package:city_folio/Views/jobsScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'Dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent log out if the user is on the home screen (index 3)
        if (selectedIndex == 3) {
          return false; // Prevent default back button behavior
        }
        if (selectedIndex == 1) {
          return false; // Prevent default back button behavior
        }
        if (selectedIndex == 2) {
          return false; // Prevent default back button behavior
        }
        if (selectedIndex == 4) {
          return false; // Prevent default back button behavior
        }
        if (selectedIndex == 0) {
          return false; // Prevent default back button behavior
        }
        if (selectedIndex == 5) {
          return false; // Prevent default back button behavior
        }
        return true; // Allow default back button behavior for other screens
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            selectedItemColor: const Color(0xFF0000FF),
            unselectedItemColor: const Color(0xFF5386E4),
            items: [
              BottomNavigationBarItem(
                icon: const FaIcon(
                  FontAwesomeIcons.house,
                ),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                icon: const FaIcon(
                  FontAwesomeIcons.calendar,
                ),
                label: 'Events'.tr,
              ),
               BottomNavigationBarItem(
                icon: const FaIcon(
                  FontAwesomeIcons.briefcase,
                ),
                label: 'Jobs'.tr,
              ),
               BottomNavigationBarItem(
                icon: const FaIcon(
                  FontAwesomeIcons.mapMarker,
                ),
                label: 'Places'.tr,
              ),
               BottomNavigationBarItem(
                icon: const FaIcon(
                  FontAwesomeIcons.businessTime,
                ),
                label: 'Business'.tr,
              ),
              BottomNavigationBarItem(
                icon: const FaIcon(
                  FontAwesomeIcons.cog,
                ),
                label: 'Profile'.tr,
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          body: selectedIndex == 0
              ? const Dashboard(
            selectedCity: '',
          )
              : selectedIndex == 1
                  ? const EventHomePage()
                  : selectedIndex == 2
                      ? const JobsScreen()
                      : selectedIndex == 3
                          ? SelectCity()
                          : selectedIndex == 4
                              ? const BusinessPortfolio()
                              : selectedIndex == 5
                                  ? const Settings()
                                  : const Settings(),
        ),
      ),
    );
  }
}
