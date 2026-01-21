import 'dart:convert';

import 'package:scan_app/data/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentHistoryStorage {
  RecentHistoryStorage._();

  static setRecentHistory(HistoryModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = [];
    data = (await prefs.getStringList('recentData') ?? []);
    data.add(jsonEncode(model.toJson()));
    // delete if list greater then 5 length
    if (data.length > 6) {
      data.removeAt(0);
    }
    await prefs.setStringList('recentData', data);
  }

  static Future<void> updateRecentHistory({
    required bool isSaved,
    required int index,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> dataList = prefs.getStringList('recentData') ?? [];

    List<HistoryModel> historyList = dataList
        .map((e) => HistoryModel.fromJson(jsonDecode(e)))
        .toList();

    historyList.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));

    if (index < 0 || index >= historyList.length) return;

    historyList[index].isSaved = isSaved;

    final updatedList = historyList.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList('recentData', updatedList);
  }
  // static updateRecentHistory({
  //   required bool isSaved,
  //   required int index,
  // }) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<HistoryModel> historyList = [];
  //   List<String> updatedList = [];
  //
  //   final List<String> dataList =
  //       (await prefs.getStringList('recentData') ?? []);
  //
  //   for (var a in dataList) {
  //     final jsonData = jsonDecode(a);
  //     historyList.add(HistoryModel.fromJson(jsonData));
  //   }
  //
  //   historyList.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
  //
  //   historyList[index].isSaved = isSaved;
  //
  //   for (var a in historyList) {
  //     updatedList.add(jsonEncode(a.toJson()));
  //   }
  //   List<String> newList = updatedList;
  //   await prefs.setStringList('recentData', newList);
  //   print(newList);
  // }

  static getRecentHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<HistoryModel> historyList = [];

    final List<String> dataList =
        (await prefs.getStringList('recentData') ?? []);

    for (var a in dataList) {
      final jsonData = jsonDecode(a);
      historyList.add(HistoryModel.fromJson(jsonData));
    }

    historyList.sort((a, b) => b.dateTime!.compareTo(a.dateTime.toString()));
    return historyList;
  }

  static clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('recentData');
    await prefs.reload();
  }
}
