class SettingsStates {}

class SoundState extends SettingsStates {
  bool isSoundON;
  SoundState({required this.isSoundON});
}

class VibrationState extends SettingsStates {
  bool isVibrate;
  VibrationState({required this.isVibrate});
}
