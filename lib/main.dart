import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organic/services/purchase_helper.dart';
import 'package:provider/provider.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'routes.dart';
import 'services/user_manager.dart';
import 'theme/style.dart';

Future<void> main() async {
  InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => BoostPurchase(),
        ), 
      ],
      child: MaterialApp(
        title: 'Organic',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        routes: routes,
      ),
    );
  }
}
