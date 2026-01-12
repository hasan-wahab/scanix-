import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_app/data/storage/histrory.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_event.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_state.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_states.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitState()) {
    on<SaveDataEvent>((event, emit) {
      if (event.isSaveInHistory == true) {
        emit(SaveHistoryState(successMsg: 'Save data'));
      } else {
        emit(SaveHistoryState(successMsg: 'Not Saved'));
      }
    });

    on<GetDataEvent>((event, emit) async {
      emit(HistoryLoadingState());
      var data = await History.getData(key: event.key);
      emit(GetHistoryState(model: data));
    });
  }
}
