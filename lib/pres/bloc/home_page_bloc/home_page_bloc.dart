import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_app/data/models/history_model.dart';
import 'package:scan_app/data/storage/recent_history.dart';
import 'package:scan_app/pres/bloc/home_page_bloc/home_page_event.dart';
import 'package:scan_app/pres/bloc/home_page_bloc/home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomeInitState()) {
    on<HomeGetHistoryEvent>((event, emit) async {
      List<HistoryModel> historyList = [];

      historyList = await RecentHistoryStorage.getRecentHistory();
      if (historyList.isNotEmpty) {
        emit(HomePageHistoryState(historyList: historyList));
      }
      emit(HomeInitState());
    });

    on<HomeDeleteAllHistoryEvent>((event, emit) async {
      await RecentHistoryStorage.clear();
      emit(HomePageHistoryState());
    });
  }
}
