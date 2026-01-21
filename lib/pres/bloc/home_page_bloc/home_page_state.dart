import 'package:scan_app/data/models/history_model.dart';

class HomePageState {}

class HomeInitState extends HomePageState {}

class HomePageHistoryState extends HomePageState {
  List<HistoryModel>? historyList = [];

  HomePageHistoryState({this.historyList});
}
