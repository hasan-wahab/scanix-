import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class ScanFeedback {
  static bool _played = false;
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> play() async {
    // sound
    await _player.play(AssetSource('sound/scanner_sound.mp3'), volume: 1.0);
  }

  static Future<void> vibration(BuildContext context) async {
    if (await Vibration.hasVibrator()) {
     Vibration.vibrate(duration: 200);
    }
  }

  static void reset() {
    _played = false;
  }
}
