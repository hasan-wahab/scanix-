import 'dart:convert';

import 'package:scan_app/data/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History {
  /// SAVE DATA
  static Future<bool> saveData({
    required String key,
    required HistoryModel model,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> oldList = prefs.getStringList(key) ?? [];

    /// ✅ Proper JSON encoding
    oldList.add(jsonEncode(model.toJson()));

    return await prefs.setStringList(key, oldList);
  }

  /// GET DATA
  static Future<List<HistoryModel>> getData({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> stringList = prefs.getStringList(key) ?? [];
    List<HistoryModel> historyList = [];

    for (String item in stringList) {
      final Map<String, dynamic> jsonMap = jsonDecode(item);
      historyList.add(HistoryModel.fromJson(jsonMap));
    }

    /// Latest first
    historyList.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));

    return historyList;
  }

  static saveCategoryList() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    List<String> defaultList = ['Personal', 'Work', 'Shopping', 'Documents'];

    await preferences.setStringList('categoryList', defaultList);
  }

  static getCategoryList() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final oldList = preferences.getStringList('categoryList');
    print(oldList);
  }

  static clear() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('data');
  }
}
