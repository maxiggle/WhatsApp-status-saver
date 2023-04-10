import 'package:flutter/material.dart';
import 'package:status_saver/status_saver_home.dart';

class StatusSaverSplash extends StatefulWidget {
  const StatusSaverSplash({super.key});

  @override
  State<StatusSaverSplash> createState() => _StatusSaverSplashState();
}

class _StatusSaverSplashState extends State<StatusSaverSplash> {
  @override
  void initState() {
    movetohomeScreen();
    super.initState();
  }

  void movetohomeScreen() {
    Future.delayed(
        const Duration(seconds: 5),
        (() => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const StatusSaverHome()))));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
