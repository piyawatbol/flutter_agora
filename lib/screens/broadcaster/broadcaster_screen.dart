import 'package:flutter/material.dart';
import 'package:flutter_agora_app/controllers/profile/profile_controller.dart';
import 'package:flutter_agora_app/widgets/text/auto_text.dart';
import 'package:get/get.dart';

import '../../widgets/drawer/drawer_home.dart';

class BroadcaterScreen extends StatelessWidget {
  BroadcaterScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xfff9f9f9),
        elevation: 0,
      ),
      drawer: DrawerHome(),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoText("Broadcaster"),
          ],
        ),
      ),
    );
  }
}
