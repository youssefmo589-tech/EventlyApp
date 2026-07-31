import 'package:shared_preferences/shared_preferences.dart';

class CheckOnBoarding {
  static Future<void> setSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seen", true);
  }

  static Future<bool> getSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("seen") ?? false;
  }
}
