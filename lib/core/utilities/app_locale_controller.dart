import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppLocaleController extends ValueNotifier<Locale> {
  AppLocaleController._(super.initialLocale);

  static const String _prefsKey = 'app_locale_code';

  static const Locale english = Locale('en');
  static const Locale arabic = Locale('ar');
  static const List<Locale> supportedLocales = [english, arabic];


  static late final AppLocaleController instance;

  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_prefsKey);
    instance = AppLocaleController._(savedCode == 'ar' ? arabic : english);
  }


  Future<void> changeLocale(Locale locale) async {
    if (value.languageCode == locale.languageCode) return;
    value = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale.languageCode);
  }
}