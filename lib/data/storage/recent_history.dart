import 'dart:convert';

import 'package:scan_app/data/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentHistoryStorage {
  RecentHistoryStorage._();

  static setData(HistoryModel model) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> dataList = [];
    List<HistoryModel> oldList = await getData();
    if (oldList.isNotEmpty) {
      oldList.add(model);
      dataList.add(oldList.toString());
      await preferences.setStringList('data', dataList);
      print(dataList);
    }
    dataList.add(jsonEncode(model.toJson()));
    await preferences.setStringList('data', dataList);
    print(dataList);
  }

  static getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    List<HistoryModel> result = [];
    List<String> dataList = await preferences.getStringList('data') ?? [];

    for (var a in dataList) {
      final jsonData = jsonDecode(a);
      HistoryModel model = HistoryModel.fromJson(jsonData);
      result.add(model);
      print(model.data);
    }
    return result;
  }
}
