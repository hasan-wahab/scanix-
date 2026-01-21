// excel_event.dart
abstract class ExportExcelEvent {}

class ExportUsersToExcel extends ExportExcelEvent {

  final String key;
  ExportUsersToExcel({required this.key});
}
