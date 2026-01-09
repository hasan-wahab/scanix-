abstract class NaveBarEvent {}

class NaveBarIndexEvent extends NaveBarEvent {
  final int value;
  NaveBarIndexEvent({required this.value});
}

class OpenScannerEvent extends NaveBarEvent {}


