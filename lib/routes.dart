import 'package:flutter/widgets.dart';
import 'package:organic/screens/denounce_screen/denounce_screen.dart';

import 'screens/about_us_screen/about_us_screen.dart';
import 'screens/boost_ad_screen/boost_ad_screen.dart';
import 'screens/change_password_screen/change_password_screen.dart';
import 'screens/create_ad_screen/create_ad_screen.dart';
import 'screens/help_screen/help_screen.dart';
import 'screens/initialization_screen/initialization_screen.dart';
import 'screens/login_screen/login_screen.dart';
import 'screens/my_account_screen/my_account_screen.dart';
import 'screens/navigation_screen/navigation_screen.dart';
import 'screens/permission_screen/permission_screen.dart';
import 'screens/product_screen/product_screen.dart';
import 'screens/recover_password_screen/recover_password_screen.dart';
import 'screens/search_result_screen/search_result_screen.dart';
import 'screens/signup_screen/signup_screen.dart';
import 'screens/thanks_screen/thanks_screen.dart';

class AppRoutes {
  static const INITIALIZATION_SCREEN = "/";
  static const NAVIGATION_SCREEN = "/navigation_screen";
  static const LOGIN_SCREEN = "/login_screen";
  static const SINGUP_SCREEN = "/singup_screen";
  static const CREATE_AD_SCREEN = "/create_ad_screen";
  static const PRODUCT_SCREEN = "/product_screen";
  static const PERMISSION_SCREEN = "/permission_screen";
  static const HELP_SCREEN = "/help_screen";
  static const MY_ACCOUNT_SCREEN = "/my_account_screen";
  static const ABOUT_US_SCREEN = "/about_us_screen";
  static const SEARCH_RESULT_SCREEN = "/search_result_screen";
  static const DENUNCIATE_SCREEN = "/denunciate_screen";
  static const RECOVER_PASSWORD_SCREEN = "/recover_password_screen";
  static const BOOST_AD_SCREEN = "/boost_ad_screen";
  static const THANKS_SCREEN = "/thanks_screen";
  static const CHANGE_PASSWORD_SCREEN = "/change_password_screen";
}

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  AppRoutes.INITIALIZATION_SCREEN: (ctx) => InitializationScreen(),
  AppRoutes.NAVIGATION_SCREEN: (ctx) => NavigationScreen(),
  AppRoutes.LOGIN_SCREEN: (ctx) => LoginScreen(),
  AppRoutes.SINGUP_SCREEN: (ctx) => SignupScreen(),
  AppRoutes.CREATE_AD_SCREEN: (ctx) => CreateAdScreen(),
  AppRoutes.PRODUCT_SCREEN: (ctx) => ProductScreen(),
  AppRoutes.PERMISSION_SCREEN: (ctx) => PermissionScreen(),
  AppRoutes.HELP_SCREEN: (ctx) => HelpScreen(),
  AppRoutes.MY_ACCOUNT_SCREEN: (ctx) => MyAccountScreen(),
  AppRoutes.ABOUT_US_SCREEN: (ctx) => AboutUsScreen(),
  AppRoutes.SEARCH_RESULT_SCREEN: (ctx) => SearchResultScreen(),
  AppRoutes.DENUNCIATE_SCREEN: (ctx) => DenounceScreen(),
  AppRoutes.RECOVER_PASSWORD_SCREEN: (ctx) => RecoverPasswordScreen(),
  AppRoutes.BOOST_AD_SCREEN: (ctx) => BoostAdScreen(),
  AppRoutes.THANKS_SCREEN: (ctx) => ThanksScreen(),
  AppRoutes.CHANGE_PASSWORD_SCREEN: (ctx) => ChangePasswordScreen(),
};
