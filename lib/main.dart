
import 'package:city_folio/lang_selection_page.dart';
import 'package:city_folio/screens/authentication_ui.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_translation.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  // Load the preferred language
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('language_code');

  // Run the app
  runApp(MyApp(languageCode: languageCode ?? 'en')); // Ensure languageCode is not null
}

class MyApp extends StatefulWidget {
  final String languageCode;
  const MyApp({Key? key, required this.languageCode}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.languageCode);
  }

  void setLocale(Locale newLocale) async {
    setState(() {
      _locale = newLocale;
      Get.updateLocale(newLocale); // Update the locale using GetX
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLocale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      translations: AppTranslations(), // Your translations
      fallbackLocale: Locale('en', ''),
      supportedLocales: [
        Locale('en', ''),
        Locale('ur', ''), // Add support for Urdu locale
        Locale('zh', ''),
      ],
      localizationsDelegates: [
        // Add MaterialLocalizations delegate for Urdu locale
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: AuthenticationUI(),
    );
  }
}


