class SettingsEvent {}

class OnLoadEvent extends SettingsEvent {}

class SoundEvent extends SettingsEvent {
  bool isSoundON;
  SoundEvent({required this.isSoundON});
}

class VibrationEvent extends SettingsEvent {
  bool isVibrate;
  VibrationEvent({required this.isVibrate});
}
