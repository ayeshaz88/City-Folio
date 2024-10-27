import 'package:city_folio/Views/HomeScreen.dart';
import 'package:city_folio/screens/authentication_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart'; // Adjust the import path to the correct location

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Select Language'.tr,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff312dA4),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('english'.tr),
            onTap: () {
              _changeLanguage(context, 'en');
            },
          ),
          ListTile(
            title: Text('urdu'.tr),
            onTap: () {
              _changeLanguage(context, 'ur');
            },
          ),
          ListTile(
            title: Text('chinese'.tr),
            onTap: () {
              _changeLanguage(context, 'zh');
            },
          ),
        ],
      ),
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) async {
    Locale newLocale = Locale(languageCode);
    MyApp.setLocale(context, newLocale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);

    // Show a Snackbar to indicate the language change
    String message = 'You are now using $languageCode language';
    Get.snackbar(
      'Language Changed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
    );
  }
}
