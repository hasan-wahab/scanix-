import 'package:shared_preferences/shared_preferences.dart';

class Practice {
  Practice._();

  static saveFirstTimeList() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('first', false);
    List<String> list = ['Personal', 'Work', 'Shoppng', 'Documents', 'Others'];
    bool? firstTime = await preferences.getBool('first');
    if (firstTime == false) {
      await preferences.setStringList('list', list);
    }
  }

  static addNewCategory(String newCategory) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final oldList = await preferences.getStringList('list');

    if (oldList!.contains(newCategory)) {
      return;
    } else {
      if (newCategory.isNotEmpty) {
        oldList.add(newCategory);
        return await oldList;
      }
      return;
    }
  }

  static getList() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.getStringList('list');
  }

  
}
