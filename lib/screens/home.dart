import 'package:flutter/material.dart';
import 'package:cobalt/screens/settings.dart';
import 'package:cobalt/screens/teleop.dart';
import 'package:cobalt/widgets/custom_elevated_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COBALT'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: CustomElevatedButton(
          width: 200,
          height: 50,
          text: 'Connect',
          textColor: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: 24,
          fontWeight: FontWeight.w300,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TeleopScreen(),
              ),
            );
          },
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.tertiaryContainer,
            ],
          ),
          borderRadius: BorderRadius.circular(100),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }
}
