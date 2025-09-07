import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {

  // =======Access Token======= //
  static void setAccessToken(String token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }
  static Future<String?> getAccessToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // =======Refresh Token======= //
  static void setRefreshToken(String token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('refresh_token', token);
  }
  static Future<String?> getRefreshToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  // =======Login Status======= //
  static void setIsLoggedIn(bool value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', value);
  }
  static Future<bool> getIsLoggedIn() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  // =======User Role======= //
  static void setUserRole(String role) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }
  static Future<String?> getUserRole() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  // =======User Type======= //
  static void setIsPremium(bool value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_premium', value);
  }
  static Future<bool> getIsPremium() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_premium') ?? false;
  }

  // =======User Pref Language======= //

  static Future<void> setLocale(Locale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale_language_code', locale.languageCode);
    await prefs.setString('locale_country_code', locale.countryCode ?? '');
  }

  // Get Locale
  static Future<Locale?> getLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('locale_language_code');
    final String? countryCode = prefs.getString('locale_country_code');

    if (languageCode == null) return null;

    if (countryCode != null && countryCode.isNotEmpty) {
      return Locale(languageCode, countryCode);
    } else {
      return Locale(languageCode);
    }
  }





}