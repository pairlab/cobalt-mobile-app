import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cobalt/models/user_settings.dart';
import 'package:sprintf/sprintf.dart';

part 'teleoperation_data.freezed.dart';

@freezed
class TeleoperationData with _$TeleoperationData {
  const TeleoperationData._();

  factory TeleoperationData({
    required int enable,
    required int valid,
    required int engaged,
    required int reset,
    required int completion,
    required int timeout,
    required int demo_decision_indicator,
    required int keep_demo_decision,
    required int grasp,
    required double time_offset,
    required Float64List? dpos,
    required Float64List? rotation,
    required bool serverReady,
    String? sessionId,
    String? deviceId,
    String? serverIp,
  }) = _TeleoperationData;

  // Teleoperation data initializer
  factory TeleoperationData.empty() => TeleoperationData(
        enable: 0,
        reset: 0,
        grasp: 0,
        valid: 0,
        engaged: 0,
        completion: 0,
        timeout: 0,
        demo_decision_indicator: 1,
        keep_demo_decision: 1,
        time_offset: 0,
        dpos: Float64List(3),
        rotation: Float64List(9),
        serverReady: false,
      );

  // Method to generate string of data that will be published over TCP
  @override
  String toString() {
    return sprintf(
      UserSettings().publishFormat,
      [
        0,
        enable,
        ...dpos!,
        grasp,
        reset,
        completion,
        timeout,
        valid,
        keep_demo_decision,
        demo_decision_indicator,
        DateTime.now().millisecondsSinceEpoch / 1000 + time_offset,
        ...rotation!,
      ],
    );
  }

  // Debugging method to generate string of data that will be published over TCP
  String toDebugString(int count) {
    return sprintf(
      UserSettings().publishFormat,
      [
        count,
        enable,
        ...dpos!,
        grasp,
        reset,
        completion,
        timeout,
        valid,
        keep_demo_decision,
        demo_decision_indicator,
        DateTime.now().millisecondsSinceEpoch / 1000 + time_offset,
        ...rotation!,
      ],
    );
  }
}
