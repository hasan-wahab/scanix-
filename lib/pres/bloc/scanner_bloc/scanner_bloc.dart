import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_app/data/handlers/scanner_handler.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_events.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_states.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerStates> {
  ScannerBloc() : super(InitState()) {
    on<OpenGalleryEvent>((e, emit) => ScannerHandler.pickImage(emit: emit));

    on<ScanQrCodeEvent>(
      (event, emit) =>
          ScannerHandler.liveScan(emit: emit, barcode: event.barcode),
    );
    on<TorchEvent>((event, emit) {
      emit(ScannerTorchState(torch: event.torch));
    });
  }
}
