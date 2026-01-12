import 'package:scan_app/data/models/history_model.dart';
import 'package:scan_app/data/storage/histrory.dart';

abstract class HistoryState {}

class HistoryInitState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class GetHistoryState extends HistoryState {
  List<HistoryModel?>? model;
  GetHistoryState({this.model});
}

class SaveHistoryState extends HistoryState {
  final String? successMsg;

  SaveHistoryState({this.successMsg});
}
