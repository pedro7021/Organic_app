import 'package:flutter/material.dart';
import 'package:organic/components/button.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes.dart';

class PermissionScreen extends StatelessWidget {
  Future<bool> _requestPermissions() async {
    final Map<Permission, PermissionStatus> _statuses = await [
      Permission.locationWhenInUse,
      Permission.storage,
      Permission.camera,
    ].request();
    if (_statuses[Permission.locationWhenInUse].isPermanentlyDenied) {
      await openAppSettings();
    }
    return _statuses[Permission.locationWhenInUse].isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Você precisa aceitar as permissões para continuar!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 16),
          Button(
            onPressed: () async {
              final bool _status = await _requestPermissions();

              if (_status) {
                Navigator.pushReplacementNamed(
                    context, AppRoutes.NAVIGATION_SCREEN);
              }
            },
            text: "Aceitar Permissões",
          ),
        ],
      ),
    );
  }
}
