// excel_state.dart
abstract class ExportExcelState {}

class ExportExcelInitial extends ExportExcelState {}

class ExportExcelLoading extends ExportExcelState {}

class ExportExcelSuccess extends ExportExcelState {
  final String filePath;

  ExportExcelSuccess(this.filePath);
}

class ExportExcelError extends ExportExcelState {
  final String message;

  ExportExcelError(this.message);
}
