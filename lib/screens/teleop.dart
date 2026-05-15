import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobalt/controllers/teleop_controller.dart';
import 'package:cobalt/providers/teleoperation_data_provider.dart';
import 'package:cobalt/providers/teleoperation_status_provider.dart';
import 'package:cobalt/widgets/custom_elevated_button.dart';
import 'package:cobalt/widgets/loading_text.dart';

class TeleopScreen extends ConsumerStatefulWidget {
  const TeleopScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TeleopScreenState();
  }
}

class _TeleopScreenState extends ConsumerState<TeleopScreen> {
  ARSessionManager? arSessionManager;
  bool firstTime = true;
  bool popped = false;
  bool _isResetDisabled = false;

  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleResetPressed() async {
      if (_isResetDisabled) return;

      setState(() {
        _isResetDisabled = true;
      });

      ref.read(teleopControllerProvider).triggerReset();

      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _isResetDisabled = false;
      });
    }

    final connected = ref.watch(teleopStatusProvider);

    // Listen for connection changes
    ref.listen(
      teleopStatusProvider,
      (bool? prevConnected, bool connected) {
        if (!popped && prevConnected == true && !connected) {
          Navigator.of(context).pop();
        }
      },
    );

    final enabled = ref.watch(teleoperationDataProvider.select((value) => value.enable));
    final valid = ref.watch(teleoperationDataProvider.select((value) => value.valid));
    final reset = ref.watch(teleoperationDataProvider.select((value) => value.reset));
    final grasped = ref.watch(teleoperationDataProvider.select((value) => value.grasp));
    final serverIp = ref.watch(teleoperationDataProvider.select((value) => value.serverIp));
    final sessionId = ref.watch(teleoperationDataProvider.select((value) => value.sessionId));
    final serverReady = ref.watch(teleoperationDataProvider.select((value) => value.serverReady));

    if (firstTime && enabled == 1) {
      firstTime = false;
    }

    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) {
        popped = true;
        ref.read(teleopControllerProvider).close();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Teleoperation'),
        ),
        body: Stack(
          children: [
            ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              alignment: Alignment.center,
              child: connected
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            width: 400,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  'Host IP: ${serverIp ?? "N/A"}\n'
                                  'Session ID: ${sessionId ?? "N/A"}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomElevatedButton(
                            width: MediaQuery.of(context).size.width * 0.4,
                            text: 'Reset',
                            fontWeight: FontWeight.w700,
                            onPressed:
                                (reset == 1 || firstTime || _isResetDisabled)
                                    ? null
                                    : handleResetPressed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(20),
                            backgroundColor: Colors.orange.shade500,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomElevatedButton(
                          text: grasped == 1 ? 'Release' : 'Grasp',
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                          onPressed: enabled == 0
                              ? null
                              : () {
                                  ref.read(teleopControllerProvider).toggleGripper();
                                },
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(120),
                          backgroundColor: Colors.blue.shade400,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey.shade800,
                        ),
                        const SizedBox(height: 20),
                        CustomElevatedButton(
                          width: MediaQuery.of(context).size.width * 0.8,
                          text: enabled == 1
                              ? 'Disable Control'
                              : 'Enable Control',
                          fontWeight: FontWeight.w700,
                          onPressed: (reset == 1 || valid == 0 || !serverReady)
                              ? null
                              : () {
                                  if (enabled == 1) {
                                    ref.read(teleopControllerProvider).handleDisable();
                                  } else {
                                    ref.read(teleopControllerProvider).handleEnable();
                                  }
                                },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(40),
                          backgroundColor: enabled == 1
                              ? Colors.redAccent.shade400
                              : Colors.greenAccent.shade700,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey.shade800,
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(),
            ),
            Positioned(
              top: 650,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: (valid == 1 && serverReady)
                      ? const Text(
                          'Connected',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : LoadingText(
                          text: !connected
                              ? 'Connecting'
                              : valid == 0
                                  ? 'Initializing Camera'
                                  : 'Waiting for available environments',
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onARViewCreated(ARSessionManager manager, _, __, ___) async {
    this.arSessionManager = manager;

    this.arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: false,
      customPlaneTexturePath: null,
      showWorldOrigin: true,
      showAnimatedGuide: false,
      handleTaps: false,
    );

    ref.read(teleopControllerProvider).setARSessionManager(manager);
  }
}
