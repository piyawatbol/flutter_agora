import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_app/controllers/splash/splash_controller.dart';
import 'package:flutter_agora_app/screens/broadcaster/broadcaster_screen.dart';
import 'package:flutter_agora_app/screens/viewer/home_viewer_screen.dart';
import 'package:flutter_agora_app/screens/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart'; // อย่าลืมตัวนี้

class SplachScreen extends StatelessWidget {
  SplachScreen({super.key});
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Container(
          width: size.width,
          height: size.height,
          child: AnimatedSplashScreen(
            splash: Container(
              width: size.width,
              height: size.height,
              child: Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            ),
            splashIconSize: 150,
            backgroundColor: Colors.white,
            duration: 1000,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            nextScreen: controller.token == null || controller.token == ""
                ? LoginScreen()
                : controller.role == "user"
                    ? HomeViewerScreen()
                    : BroadcaterScreen(),
          ),
        );
      },
    ));
  }
}
