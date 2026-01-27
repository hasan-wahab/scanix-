import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class ScanFeedback {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> play({required bool isPlay}) async {
    // sound
    if (isPlay == true) {
      await _player.play(AssetSource('sound/scanner_sound.mp3'), volume: 1.0);
    }
  }

  static Future<void> vibration({required bool isVibrate}) async {
    if (isVibrate == true) {
      await Vibration.vibrate(duration: 200);
    }
  }
}
