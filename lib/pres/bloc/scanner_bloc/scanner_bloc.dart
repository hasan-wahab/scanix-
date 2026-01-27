import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_app/data/handlers/scanner_handler.dart';
import 'package:scan_app/data/handlers/vibrate_handler.dart';
import 'package:scan_app/data/storage/settings_storage.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_events.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_states.dart';
import 'package:scan_app/pres/bloc/setting_bloc/settings_bloc.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerStates> {
  ScannerBloc() : super(InitState()) {
    on<OpenGalleryEvent>(
      (e, emit) => ScannerHandler.pickImage(emit: emit, context: e.context),
    );

    on<ScanQrCodeEvent>(
      (event, emit) => ScannerHandler.liveScan(
        emit: emit,
        barcode: event.barcode,
        context: event.context,
      ),
    );
    on<TorchEvent>((event, emit) {
      emit(ScannerTorchState(torch: event.torch));
    });

    on<ScanVibrationSoundEvent>((event, emit) async {
      final isPlay = await SettingsStorage.getSound();
      final isVibrate = await SettingsStorage.getVibration();
      await ScanFeedback.vibration(isVibrate: isVibrate);
      await ScanFeedback.play(isPlay: isPlay);
    });
  }
}
