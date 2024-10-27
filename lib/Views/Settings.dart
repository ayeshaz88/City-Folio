import 'package:city_folio/Admin/AcceptBusiness.dart';
import 'package:city_folio/Admin/AcceptJob.dart';
import 'package:city_folio/Admin/AcceptPlace.dart';
import 'package:city_folio/Views/favoritePlaces.dart';
import 'package:city_folio/Views/profileSettings.dart';
import 'package:city_folio/Widgets/HomeScreenWidgets/Header.dart';
import 'package:city_folio/currency_converter.dart';
import 'package:city_folio/lang_selection_page.dart';
import 'package:city_folio/screens/authentication_ui.dart';
import 'package:city_folio/screens/fade_animationtest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FadeInAnimation(
          delay: 1.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(title: 'Settings'.tr),
              const SizedBox(height: 10),
              _buildSettingsOption(
                icon: Icons.person,
                title: 'Update Profile'.tr,
                onTap: () => Get.to(() => const ProfileSettings()),
              ),
              SizedBox(height: 05),
              _buildSettingsOption(
                icon: Icons.favorite,
                title: 'Favorite Places'.tr,
                onTap: () => Get.to(() => const FavoritePlaces()),
              ),
              SizedBox(height: 05),
              _buildSettingsOption(
                icon: Icons.business_center,
                title: 'New Businesses'.tr,
                onTap: () => Get.to(() => AcceptBusiness()),
              ),
              SizedBox(height: 05),
              _buildSettingsOption(
                icon: Icons.place,
                title: 'Suggested Place'.tr,
                onTap: () => Get.to(() => AcceptPlace()),
              ),
              SizedBox(height: 05),
              _buildSettingsOption(
                icon: Icons.work,
                title: 'Accepted Jobs'.tr,
                onTap: () => Get.to(() => AcceptJob()),
              ),
              SizedBox(height: 05),
              _buildSettingsOption(
                icon: Icons.language,
                title: 'Select Language'.tr,
                onTap: () => Get.to(() => LanguageSelectionPage()),
              ),
              SizedBox(height: 05),
              _buildSettingsOption(
                icon: Icons.currency_exchange,
                title: 'Convert Currency'.tr,
                onTap: () => Get.to(() => CurrencyConverter()),
              ),
              SizedBox(height: 05),
              _buildSettingsOption(
                icon: Icons.exit_to_app,
                title: 'Logout'.tr,
                onTap: () => Get.to(() => AuthenticationUI()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 16),
            Text(
              title.tr,
              style: TextStyle(
                  // Adjust the font size here
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
