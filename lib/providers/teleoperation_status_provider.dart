import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeleoperationStatus extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void updateStatus(bool status) {
    state = status;
  }
}

final teleopStatusProvider = NotifierProvider<TeleoperationStatus, bool>(() {
  return TeleoperationStatus();
});
