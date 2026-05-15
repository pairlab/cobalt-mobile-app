import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobalt/models/teleoperation_incoming_data.dart';

class TeleoperationIncomingDataProvider extends Notifier<TeleoperationIncomingData> {
  @override
  TeleoperationIncomingData build() {
    return TeleoperationIncomingData.empty();
  }

  void updateData({
    int? remoteResetBit,
    int? remoteTaskCompletionBit,
    int? remoteTaskTimeoutBit,
  }) {
    state = state.copyWith(
      remoteResetBit: remoteResetBit ?? state.remoteResetBit,
      remoteTaskCompletionBit: remoteTaskCompletionBit ?? state.remoteTaskCompletionBit,
      remoteTaskTimeoutBit: remoteTaskTimeoutBit ?? state.remoteTaskTimeoutBit,
    );
  }
}

final teleoperationIncomingDataProvider = NotifierProvider<TeleoperationIncomingDataProvider, TeleoperationIncomingData>(
  TeleoperationIncomingDataProvider.new,
);
