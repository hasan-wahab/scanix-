import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  SettingsStorage._();

  static Future<bool> getSound({bool? isOn}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result;

    bool? isFirstTime = await prefs.getBool('sound');

    if (isFirstTime == null) {
      await prefs.setBool('sound', true);
    }

    if (isOn != null) {
      await prefs.setBool('sound', isOn);
    }

    result = await prefs.getBool('sound')!;
    return result;
  }

  static Future<bool> getVibration({bool? vibration}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result;
    bool? isFirstTime = await prefs.getBool('vibration');
    if (isFirstTime == null) {
      await prefs.setBool('vibration', true);
    }

    if (vibration != null) {
      await prefs.setBool('vibration', vibration);
    }

    result = await prefs.getBool('vibration')!;
    return result;
  }
}
