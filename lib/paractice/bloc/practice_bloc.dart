import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_app/data/storage/histrory.dart';
import 'package:scan_app/paractice/bloc/practice_event.dart';
import 'package:scan_app/paractice/bloc/practice_state.dart';
import 'package:scan_app/paractice/practice.dart';

class PracticeBloc extends Bloc<PracticeEvent, PracticeState> {
  PracticeBloc() : super(PracticeState()) {
    on<AddInitCate>((event, emit) async {
      await Practice.saveFirstTimeList();

      List<String> getList = await Practice.getList() ?? [];
      emit(PracticeState(cateList: getList));
    });

    on<AddPracticeCategoryEvent>((event, emit) async {
      List<String> getOldList = await Practice.getList();
      getOldList.add(event.newCate);
    });
  }
}
