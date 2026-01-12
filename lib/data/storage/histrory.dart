import 'dart:convert';

import 'package:scan_app/data/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History {
  static saveData({required String key, required HistoryModel model}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> oldList = [];
    HistoryModel _model = HistoryModel(
      scanType: model.scanType,
      date: model.date,
      data: model.date,
      category: model.category,
      productName: model.productName,
    );
    oldList = (preferences.getStringList(key)) ?? [];

    oldList.add(jsonEncode(_model.toJson()));

    final dataList = await preferences.setStringList(key, oldList);
    print(dataList);

    return dataList;
  }

  static Future<List<HistoryModel?>> getData({required String key}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    List<HistoryModel> historyData = [];

    final List<String>? stringData = await preferences.getStringList(key);

    if (stringData != null) {
      for (var a in stringData) {
        final jsonData = jsonDecode(a);
        final data = HistoryModel.fromJson(jsonData);
        historyData.add(data);
      }
      historyData.sort((a, b) => b.date.toString().compareTo(a.date!.toString()));

      print(historyData.first.date);
      return historyData;
    }
    return historyData;
  }

  static clear() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
