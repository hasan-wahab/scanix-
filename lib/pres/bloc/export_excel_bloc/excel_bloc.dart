import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:scan_app/data/storage/histrory.dart';
import '../../../data/models/history_model.dart';
import 'excel_event.dart';
import 'excel_state.dart';

class ExportExcelBloc extends Bloc<ExportExcelEvent, ExportExcelState> {
  ExportExcelBloc() : super(ExportExcelInitial()) {
    on<ExportUsersToExcel>(_exportUsers);
  }

  Future<void> _exportUsers(
    ExportUsersToExcel event,
    Emitter<ExportExcelState> emit,
  ) async {
    try {
      emit(ExportExcelLoading());

      // Create Excel
      final excel = Excel.createExcel();

      // Rename default sheet to History
      excel.rename('Sheet1', 'History');
      final sheet = excel['History'];

      /// Headers
      List<String> headers = [
        'Product Name',
        'Category',
        'Scan Type',
        'Data',
        'Date',
      ];
      sheet.appendRow(headers.map((h) => TextCellValue(h)).toList());

      /// Fetch history
      final List<HistoryModel?> list = await History.getData(key: event.key);

      if (list.isEmpty) {
        throw Exception('No history data to export');
      }

      /// Track max length for each column
      List<int> maxColLengths = List.filled(headers.length, 0);

      // Initialize max lengths with header length
      for (int i = 0; i < headers.length; i++) {
        maxColLengths[i] = headers[i].length;
      }

      /// Rows
      for (final h in list) {
        if (h != null) {
          // Safe date formatting
          String dateText = '';
          if (h.dateTime != null && h.dateTime!.isNotEmpty) {
            final dt = DateTime.tryParse(h.dateTime!);
            if (dt != null) {
              dateText = DateFormat('EEEE, dd MMM yyyy').format(dt);
            }
          }

          List<String> rowData = [
            h.productName ?? '',
            h.category ?? '',
            h.scanType ?? '',
            h.data ?? '',
            dateText,
          ];

          // Append row
          sheet.appendRow(rowData.map((e) => TextCellValue(e)).toList());

          // Update max column length
          for (int i = 0; i < rowData.length; i++) {
            if (rowData[i].length > maxColLengths[i]) {
              maxColLengths[i] = rowData[i].length;
            }
          }
        }
      }

      /// Set column width dynamically
      for (int i = 0; i < maxColLengths.length; i++) {
        sheet.setColumnWidth(i, (maxColLengths[i] * 1.2));
      }

      /// Encode Excel
      final encoded = excel.encode();
      if (encoded == null) throw Exception('Excel encode failed');

      final Uint8List bytes = Uint8List.fromList(encoded);

      /// Save Excel (user chooses location)
      final String? path = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Excel File',
        fileName: 'history.xlsx',
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        bytes: bytes,
      );

      if (path == null) {
        emit(ExportExcelInitial());
        return;
      }

      emit(ExportExcelSuccess(path));
    } catch (e) {
      emit(ExportExcelError(e.toString()));
    }
  }
}
