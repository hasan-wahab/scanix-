import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_app/data/storage/settings_storage.dart';
import 'package:scan_app/pres/bloc/setting_bloc/settings_event.dart';
import 'package:scan_app/pres/bloc/setting_bloc/settings_states.dart'
    hide SoundEvent;

class SettingsBloc extends Bloc<SettingsEvent, SettingsStates> {
  SettingsBloc() : super(SettingsStates()) {
    on<SoundEvent>((event, emit) async {
      await SettingsStorage.soundOnOff(event.isSoundON);
      bool isSound = await SettingsStorage.getSound();
      emit(SoundState(isSoundON: isSound));
    });
    on<VibrationEvent>((event, emit) async {
      await SettingsStorage.vibrationOnOff(event.isVibrate);
      bool isVibrate = await SettingsStorage.getVibration();
      emit(VibrationState(isVibrate: isVibrate));
    });
  }
}
