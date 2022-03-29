import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes.dart';

class InitializationScreen extends StatefulWidget {
  @override
  _InitializationScreenState createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen>
    with AfterLayoutMixin<InitializationScreen> {
  Future<bool> _requestPermissions() async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
      Permission.storage,
      Permission.camera,
    ].request();
    if (statuses[Permission.locationWhenInUse].isPermanentlyDenied) {
      await openAppSettings();
    }
    return statuses[Permission.locationWhenInUse].isGranted;
  }

  Future rightScreen() async {
    final bool status = await _requestPermissions();
    if (status) {
      Navigator.pushReplacementNamed(context, AppRoutes.NAVIGATION_SCREEN);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.PERMISSION_SCREEN);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => rightScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
              child: Image.asset("assets/logo.png"),
            ),
            const Text(
              "Organic",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 52,color:Color(0xFF01A305),fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
