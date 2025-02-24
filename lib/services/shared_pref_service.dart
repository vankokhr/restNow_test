import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _keyMassageIntensity = 'massageIntensity';

  static Future<int> getMassageIntensity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyMassageIntensity) ?? 1;
  }

  static Future<void> setMassageIntensity(int intensity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyMassageIntensity, intensity);
  }
}
