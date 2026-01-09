import 'package:scan_app/pres/bloc/nave_bar_bloc/nav_bar_event.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NaveBarBloc extends Bloc<NaveBarEvent, NaveBarState> {
  NaveBarBloc() : super(NaveBarState()) {
    on<NaveBarIndexEvent>((event, emit) {
      emit(NaveBarState(value: event.value));
      print(state.value);
    });
    on<OpenScannerEvent> ((event,emit){
      emit(OpenScannerState());
    });
  }
}
