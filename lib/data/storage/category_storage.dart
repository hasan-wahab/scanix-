import 'package:shared_preferences/shared_preferences.dart';

class CategoryStorage {
  static const List<String> _defaultCategories = [
    'Personal',
    'Work',
    'Shopping',
    'Documents',
  ];

  static Future<void> initIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();

    final isInitialized = prefs.getBool('categories_initialized') ?? false;

    if (!isInitialized) {
      await prefs.setStringList('categoryList', _defaultCategories);
      await prefs.setBool('categories_initialized', true);
    }
  }

  static Future<List<String>> getList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('categoryList') ?? [];
  }

  static Future<void> add(String category) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('categoryList') ?? [];

    if (!list.contains(category)) {
      list.add(category);
      await prefs.setStringList('categoryList', list);
    }
  }
}
