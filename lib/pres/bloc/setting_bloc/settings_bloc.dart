import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_app/data/storage/settings_storage.dart';
import 'package:scan_app/pres/bloc/setting_bloc/settings_event.dart';
import 'package:scan_app/pres/bloc/setting_bloc/settings_states.dart'
    hide SoundEvent;

class SettingsBloc extends Bloc<SettingsEvent, SettingsStates> {
  SettingsBloc() : super(SettingsStates()) {
    on<OnLoadEvent>((event, emit) async {
      bool vibration = await SettingsStorage.getVibration();
      bool sound = await SettingsStorage.getSound();
      emit(SettingsStates(vibration: vibration, sound: sound));
    });
    on<SoundEvent>((event, emit) async {
      bool sound = await SettingsStorage.getSound(
        isOn: state.sound = !state.sound!,
      );
      emit(SettingsStates(sound: sound, vibration: state.vibration));
      print('sound ${state.sound}');
    });

    on<VibrationEvent>((event, emit) async {
      bool vibration = await SettingsStorage.getVibration(
        vibration: state.vibration = !state.vibration,
      );
      emit(SettingsStates(vibration: vibration, sound: state.sound));
      print('sound ${state.vibration}');
    });
  }
}
