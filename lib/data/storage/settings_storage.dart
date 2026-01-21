import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  SettingsStorage._();

  static soundOnOff(bool sound) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('sound', sound = !sound);
  }

  static Future<bool> getSound() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool result = prefs.getBool('sound') ?? true;

    return result;
  }

  static vibrationOnOff(bool isOn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('vibrate', isOn = !isOn);
  }

  static Future<bool> getVibration() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool result = prefs.getBool('vibrate') ?? true;

    return result;
  }
}
