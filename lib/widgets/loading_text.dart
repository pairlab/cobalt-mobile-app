import 'dart:async';
import 'package:flutter/material.dart';

class LoadingText extends StatefulWidget {
  const LoadingText({super.key, required this.text});

  final String text;

  @override
  State<StatefulWidget> createState() {
    return _LoadingTextState();
  }
}

class _LoadingTextState extends State<LoadingText> {
  String _loadingText = "";
  int _dotCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startLoadingAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLoadingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
        _loadingText = widget.text + '.' * _dotCount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _loadingText,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
