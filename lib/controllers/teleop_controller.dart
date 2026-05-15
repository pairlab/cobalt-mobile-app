import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobalt/models/user_settings.dart';
import 'package:cobalt/providers/teleoperation_data_provider.dart';
import 'package:cobalt/providers/teleoperation_incoming_data_provider.dart';
import 'package:cobalt/providers/teleoperation_status_provider.dart';
import 'package:cobalt/services/websocket_handler.dart';
import 'package:ntp/ntp.dart';
import 'package:vector_math/vector_math_64.dart';

class TeleopController {
  ARSessionManager? arSessionManager;
  Timer? commTimer;
  Ref ref;
  Matrix4? ARRefPose;
  Matrix4? ARRefPoseInv;
  Vector3 lastPos = Vector3.zero();
  bool controlEnabled = false;
  bool _isClosed = false;
  VoidCallback? onMovingTooFast;
  Matrix3? lastRotation;
  final double rotationThreshold = 0.2;
  int messageCount = 0;

  TeleopController(this.ref, {this.onMovingTooFast});

  // EEF frame pose in the phone frame (portrait orientation held horizontally)
  final Matrix4 EEFFrameInPhone = Matrix4(-1, 0, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1);

  Future<double> calculateTimeOffset() async {
    int totalOffset = 0;
    const int numRequests = 10;
    int actualRequests = 0;

    for (int i = 0; i < numRequests; i++) {
      try {
        totalOffset += await NTP.getNtpOffset(localTime: DateTime.now());
        actualRequests++;
      } catch (e) {
        print('[NTP] Network call $i failed: $e');
      }
      await Future.delayed(const Duration(milliseconds: 50));
    }

    if (actualRequests == 0) {
      print('[NTP] All network requests FAILED! No time offset added!');
      return 0;
    }

    final offsetSeconds = (totalOffset / numRequests) / 1000;
    print('[NTP] Time offset: $offsetSeconds');
    return offsetSeconds;
  }

  Future<void> connect() async {
    final configData = {
      'sim': 'Robosuite',
      'sim_type': UserSettings().bimanual ? 'bimanual' : 'single',
      'arm': 'left',
      'username': UserSettings().username,
    };

    if (_isClosed) {
      return;
    }

    final configString = json.encode(configData);
    print('Config string: $configString');

    ref.read(teleoperationDataProvider.notifier).updateData(time_offset: await calculateTimeOffset());

    final success = await ref.read(websocketHandlerProvider).connect(handleResponse, configString);
    if (!success) {
      print('Failed to connect to server. Go back and try again.');
      return;
    }

    await calibrateCamera();
  }

  void _disposeResources() {
    commTimer?.cancel();
    commTimer = null;
  }

  void close() {
    _isClosed = true;
    ref.read(websocketHandlerProvider).close();
    ref.invalidate(teleoperationDataProvider);
    ref.invalidate(teleoperationIncomingDataProvider);
    ref.invalidate(teleopStatusProvider);
    _disposeResources();
    ref.invalidateSelf();
  }

  Future<void> publishCommData() async {
    if (!ref.read(teleopStatusProvider)) {
      close();
    }

    final mat = await updatePublishData();

    if (mat == null) {
      return;
    }

    final currentRotation = mat.getRotation();

    if (_isRotatingTooFast(currentRotation)) {
      ref.read(teleoperationDataProvider.notifier).updateData(enable: 0);
      HapticFeedback.mediumImpact();
      onMovingTooFast?.call();
      return;
    }

    final currentPos = mat.getTranslation();
    if (lastPos == null) {
      lastPos = currentPos;
      lastRotation = currentRotation;
      return;
    }

    if (_isTranslatingTooFast(currentPos)) {
      ref.read(teleoperationDataProvider.notifier).updateData(enable: 0);
      HapticFeedback.mediumImpact();
      return;
    }

    ref.read(teleoperationDataProvider.notifier).updateData(
      dpos: (currentPos - lastPos).storage,
      rotation: currentRotation.transposed().storage,
    );

    lastPos = currentPos;

    final message = ref.read(teleoperationDataProvider).toDebugString(messageCount);
    messageCount++;
    ref.read(websocketHandlerProvider).publish('device data', message);
  }

  bool _isRotatingTooFast(Matrix3 currentRotation) {
    if (lastRotation == null) {
      return false;
    }

    final q1 = Quaternion.fromRotation(currentRotation);
    final q2 = Quaternion.fromRotation(lastRotation!);

    final dot = q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w;
    final angle = 2 * acos(dot.clamp(-1.0, 1.0));

    if (angle > rotationThreshold) {
      print('Rotating too fast. Angle (radians): $angle');
      return true;
    }

    return false;
  }

  bool _isTranslatingTooFast(Vector3 currentPos) {
    if (ref.read(teleoperationDataProvider).enable != 1) {
      return false;
    }

    const threshold = 0.04;
    Vector3 delta = currentPos - lastPos!;
    return delta.x.abs() > threshold || delta.y.abs() > threshold || delta.z.abs() > threshold;
  }

  Future<Matrix4?> updatePublishData() async {
    return await arSessionManager?.getCameraPose().then(
      (Matrix4? mat) {
        if (mat == null) {
          print('Camera pose is null');
          return null;
        }

        if (ARRefPose == null && controlEnabled) {
          ARRefPose = mat;
          ARRefPoseInv = invertPoseMatrix(ARRefPose!);
          controlEnabled = false;          
        }

        if (ARRefPose != null) {
          // get the relative pose of the phone with respect to the reference pose
          mat = ARRefPoseInv!.multiplied(mat).multiplied(EEFFrameInPhone);
          return mat;
        }
        return Matrix4.zero();
      },
    );
  }

  Matrix4 invertPoseMatrix(Matrix4 pose) {
    final inverse1 = Matrix4(
      pose[0], pose[4], pose[8], 0,
      pose[1], pose[5], pose[9], 0,
      pose[2], pose[6], pose[10], 0,
      0, 0, 0, 1,
    );
    final inverse2 = Matrix4(
      1, 0, 0, 0,
      0, 1, 0, 0,
      0, 0, 1, 0,
      -pose[12], -pose[13], -pose[14], 1,
    );
    return inverse1.multiplied(inverse2);
  }

  void setARSessionManager(ARSessionManager manager) async {
    this.arSessionManager = manager;
    this.connect();
  }

  Future<void> calibrateCamera() async {
    bool initializing = true;
    
    if (!ref.read(teleopStatusProvider) || _isClosed) {
      return;
    }

    while (initializing) {
      arSessionManager?.getCameraPose().then((Matrix4? mat) {
        if (mat != null) {
          print('Camera pose initialized');
          initializing = false;
        } else {
          print('Camera pose is null');
        }

        if (_isClosed) {
          return;
        }
      });
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await Future.delayed(const Duration(seconds: 3));
    ref.read(teleoperationDataProvider.notifier).updateData(valid: 1);
  }

  void toggleGripper() {
    ref.read(teleoperationDataProvider.notifier).toggleGrasp();
  }

  void setControlEnabled(bool newControlEnabled) {
    controlEnabled = newControlEnabled;
    print('Changed controlEnabled to: $controlEnabled');
  }

  void handleEnable() {
    if (commTimer == null) {
      commTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if (ref.read(teleoperationDataProvider.notifier).getServerReady()) {
          unawaited(publishCommData());
        }
      });
    }

    ref.read(teleoperationDataProvider.notifier).updateData(enable: 1);
  }

  void handleDisable() {
    ref.read(teleoperationDataProvider.notifier).updateData(enable: 0);
  }

  void handleResponse(Uint8List data) {
    final message = utf8.decode(data);
    final Map<String, dynamic> decodedJson = jsonDecode(message);
    final String type = decodedJson['type'];
    final serverData = decodedJson['data'];

    print('type: $type');

    switch (type) {
      case 'init':
        final String sessionId = serverData['session_id'];
        final String deviceId = serverData['device_id'];
        final String serverIp = serverData['server_ip'];

        ref.read(teleoperationDataProvider.notifier).updateSessionInfo(
          sessionId: sessionId,
          deviceId: deviceId,
          serverIp: serverIp,
        );
        break;
      case 'status':
        if (serverData['ready']) {
          ref.read(teleoperationDataProvider.notifier).updateServerReady(serverReady: serverData['ready']);
        }
        break;
      case 'response':
        final Map<String, dynamic> responseData = jsonDecode(serverData);
        final int remoteResetBit = responseData['reset'];
        final int remoteTaskCompletionBit = responseData['complete'];
        final int remoteTaskTimeoutBit = responseData['timeout'];

        ref.read(teleoperationIncomingDataProvider.notifier).updateData(
              remoteResetBit: remoteResetBit,
              remoteTaskCompletionBit: remoteTaskCompletionBit,
              remoteTaskTimeoutBit: remoteTaskTimeoutBit,
            );
        break;
      default:
        print('Invalid message header sent from server');
    }
  }

  void triggerReset() {
    ref.read(teleoperationDataProvider.notifier).updateData(reset: 1);
  }

  void resetAR() {
    ARRefPose = null;
    ARRefPoseInv = null;
    lastPos = Vector3.zero();
  }

  void handleReset() {
    print('Handling task reset');
    ref.read(teleoperationDataProvider.notifier).updateData(
          enable: 0,
          grasp: 0,
          keep_demo_decision: 0,
        );
    ref.read(teleoperationDataProvider.notifier).toggleDemoDecisionIndicator();

    // Reset AR reference pose
    resetAR();

    // Enable reset button again
    ref.read(teleoperationDataProvider.notifier).updateData(reset: 0);
  }

  void handleTaskCompletion() {
    print('Handling task completion');
    ref.read(teleoperationDataProvider.notifier).updateData(
          enable: 0,
          grasp: 0,
          keep_demo_decision: 1,
        );
    ref.read(teleoperationDataProvider.notifier).toggleDemoDecisionIndicator();

    resetAR();

    ref.read(teleoperationDataProvider.notifier).toggleCompletion();
  }

  void handleTaskTimeout() {
    print('Handling task timeout');
    ref.read(teleoperationDataProvider.notifier).updateData(
          enable: 0,
          grasp: 0,
          keep_demo_decision: 0,
        );
    ref.read(teleoperationDataProvider.notifier).toggleDemoDecisionIndicator();

    resetAR();

    ref.read(teleoperationDataProvider.notifier).toggleTimeout();
  }
}

final teleopControllerProvider = Provider<TeleopController>((ref) {
  final controller = TeleopController(ref);

  ref.onDispose(() {
    controller._disposeResources();
  });

  ref.listen(
    teleoperationDataProvider.select((data) => data.enable),
    (int? prevEnable, int enable) {
      if (prevEnable == 0 && enable == 1) {
        controller.setControlEnabled(true);
      } else if (prevEnable == 1 && enable == 0) {
        controller.setControlEnabled(false);
      }
    },
  );

  ref.listen(
    teleoperationIncomingDataProvider.select((data) => data.remoteResetBit),
    (int? prevRemoteResetBit, int remoteResetBit) {
      print('$prevRemoteResetBit -> $remoteResetBit');
      if (remoteResetBit != prevRemoteResetBit) {
        controller.handleReset();
        ref.read(teleoperationDataProvider.notifier).updateData(reset: 0);
      }
    },
  );

  ref.listen(
    teleoperationIncomingDataProvider
        .select((data) => data.remoteTaskCompletionBit),
    (int? prevRemoteTaskCompletionBit, int remoteTaskCompletionBit) {
      if (prevRemoteTaskCompletionBit == 0 && remoteTaskCompletionBit == 1) {
        controller.handleTaskCompletion();
      }
    },
  );

  ref.listen(
    teleoperationIncomingDataProvider
        .select((data) => data.remoteTaskTimeoutBit),
    (int? prevRemoteTaskTimeoutBit, int remoteTaskTimeoutBit) {
      if (prevRemoteTaskTimeoutBit == 0 && remoteTaskTimeoutBit == 1) {
        controller.handleTaskTimeout();
      }
    },
  );

  return controller;
});
