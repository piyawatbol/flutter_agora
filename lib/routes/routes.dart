import 'package:flutter_agora_app/screens/broadcaster/broadcaster_screen.dart';
import 'package:flutter_agora_app/screens/viewer/home_viewer_screen.dart';
import 'package:flutter_agora_app/screens/register/register_screen.dart';
import 'package:flutter_agora_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/login/login_screen.dart';

class AppRoutes {
  static final splash = '/';
  static final login = '/login';
  static final home_viewer = '/home_viewer';
  static final register = '/regsiter';
  static final broadcaster = '/broadcaster';

  static final getPages = [
    GetPage(name: splash, page: () => SplachScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: home_viewer, page: () => HomeViewerScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: broadcaster, page: () => BroadcaterScreen()),
  ];
}
