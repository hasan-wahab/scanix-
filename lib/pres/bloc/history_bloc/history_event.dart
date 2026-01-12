import 'package:scan_app/data/models/history_model.dart';

abstract class HistoryEvent {}

class SaveDataEvent extends HistoryEvent {
  bool isSaveInHistory;

  SaveDataEvent({required this.isSaveInHistory});
}

class GetDataEvent extends HistoryEvent{
  String key;
  GetDataEvent({required this.key});
}
