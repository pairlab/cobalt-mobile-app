import 'package:freezed_annotation/freezed_annotation.dart';

part 'teleoperation_incoming_data.freezed.dart';

@freezed
class TeleoperationIncomingData with _$TeleoperationIncomingData {
  const TeleoperationIncomingData._();

  factory TeleoperationIncomingData({
    required int remoteResetBit,
    required int remoteTaskCompletionBit,
    required int remoteTaskTimeoutBit,
  }) = _TeleoperationIncomingData;

  // Teleoperation data initializer
  factory TeleoperationIncomingData.empty() => TeleoperationIncomingData(
        remoteResetBit: 0,
        remoteTaskCompletionBit: 0,
        remoteTaskTimeoutBit: 0,
      );
}
