import 'package:flutter/widgets.dart';
import 'app_translation.dart';

String t(BuildContext context, String key) {
  return AppTranslations.of(context)?.translate(key) ?? key;
}
