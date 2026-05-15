import 'package:flutter/material.dart';
import 'package:cobalt/models/user_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const SettingsContent(),
    );
  }
}

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent>
    with WidgetsBindingObserver {
  final UserSettings settings;
  late Map<Setting, dynamic> _settings;

  final List<String> _tasks = [
    'test',
    'liftCube',
    'stackCube',
    'mugPour',
    'threePieceAssembly',
    'threading',
    'bananaCleanup',
    'kitchen'
  ];

  _SettingsContentState() : settings = UserSettings() {
    _settings = Map.from(settings.allSettings);
  }

  final TextEditingController _ipAddressController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _sessionIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeControllers();
  }

  void _initializeControllers() {
    _ipAddressController.text = _settings[Setting.IPAddress];
    _portController.text = _settings[Setting.Port].toString();
    _usernameController.text = _settings[Setting.username];
    _sessionIdController.text = _settings[Setting.sessionId];
  }

  @override
  void dispose() {
    _ipAddressController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _sessionIdController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      await settings.updateSettings(_settings);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        await settings.updateSettings(_settings);
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 2,
            child: Column(
              children: [
                createTextFieldTile(
                  text: 'Username',
                  controller: _usernameController,
                  onChanged: (value) => value.isNotEmpty
                      ? _settings[Setting.username] = value
                      : _settings[Setting.username] =
                          defaultSettings[Setting.username],
                  containerWidth: 200,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.text,
                ),
                createTextFieldTile(
                  text: 'Server IP Address',
                  controller: _ipAddressController,
                  onChanged: (value) => value.isNotEmpty
                      ? _settings[Setting.IPAddress] = value
                      : _settings[Setting.IPAddress] =
                          defaultSettings[Setting.IPAddress],
                  containerWidth: 200,
                  textAlign: TextAlign.right,
                  maxLength: 15,
                ),
                createTextFieldTile(
                  text: 'Server Port',
                  controller: _portController,
                  onChanged: (value) => _settings[Setting.Port] =
                      int.tryParse(value) ?? defaultSettings[Setting.Port],
                  containerWidth: 200,
                  textAlign: TextAlign.right,
                  maxLength: 5,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                const Text('Select Task'),
                DropdownButton<String>(
                  value: _settings[Setting.task],
                  items: _tasks
                      .map((task) => DropdownMenuItem(
                            value: task,
                            child: Text(task),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _settings[Setting.task] = newValue ?? 'Lift_Cube';
                    });
                  },
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Bimanual'),
                      Switch(
                        value: _settings[Setting.bimanual],
                        onChanged: (bool newValue) {
                          setState(() {
                            _settings[Setting.bimanual] = newValue;
                            if (!newValue) {
                              _settings[Setting.sessionId] = '';
                              _sessionIdController.clear();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (_settings[Setting.bimanual])
                  createTextFieldTile(
                    text: 'Session ID',
                    controller: _sessionIdController,
                    onChanged: (value) => value.isNotEmpty
                        ? _settings[Setting.sessionId] = value
                        : _settings[Setting.sessionId] =
                            defaultSettings[Setting.sessionId],
                    containerWidth: 200,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.text,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createTextFieldTile({
    required String text,
    required TextEditingController controller,
    required void Function(String) onChanged,
    double containerWidth = 150,
    TextAlign textAlign = TextAlign.left,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          SizedBox(
            width: containerWidth,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              maxLength: maxLength,
              textAlign: textAlign,
              keyboardType: keyboardType,
              decoration: const InputDecoration(
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
