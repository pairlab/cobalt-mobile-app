import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobalt/models/teleoperation_data.dart';

class TeleoperationDataProvider extends Notifier<TeleoperationData> {
  @override
  TeleoperationData build() {
    return TeleoperationData.empty();
  }

  void updateData({
    int? enable,
    int? valid,
    int? engaged,
    int? reset,
    int? completion,
    int? timeout,
    int? demo_decision_indicator,
    int? keep_demo_decision,
    int? grasp,
    double? time_offset,
    Float64List? dpos,
    Float64List? rotation,
  }) {
    state = state.copyWith(
      enable: enable ?? state.enable,
      valid: valid ?? state.valid,
      engaged: engaged ?? state.engaged,
      reset: reset ?? state.reset,
      completion: completion ?? state.completion,
      timeout: timeout ?? state.timeout,
      demo_decision_indicator: demo_decision_indicator ?? state.demo_decision_indicator,
      keep_demo_decision: keep_demo_decision ?? state.keep_demo_decision,
      grasp: grasp ?? state.grasp,
      time_offset: time_offset ?? state.time_offset,
      dpos: dpos ?? state.dpos,
      rotation: rotation ?? state.rotation,
    );
  }

  void updateSessionInfo({
    required String sessionId,
    required String deviceId,
    required String serverIp,
  }) {
    state = state.copyWith(
      sessionId: sessionId,
      deviceId: deviceId,
      serverIp: serverIp,
    );
  }

  void updateServerReady({required bool serverReady}) {
    state = state.copyWith(serverReady: serverReady);
  }

  bool getServerReady() {
    return state.serverReady;
  }

  void toggleDemoDecisionIndicator() {
    state = state.copyWith(demo_decision_indicator: 1 - state.demo_decision_indicator);
  }

  void toggleGrasp() {
    state = state.copyWith(grasp: 1 - state.grasp);
  }

  void toggleCompletion() {
    state = state.copyWith(completion: 1 - state.completion);
  }

  void toggleTimeout() {
    state = state.copyWith(timeout: 1 - state.timeout);
  }
}

final teleoperationDataProvider = NotifierProvider<TeleoperationDataProvider, TeleoperationData>(
  TeleoperationDataProvider.new,
);
