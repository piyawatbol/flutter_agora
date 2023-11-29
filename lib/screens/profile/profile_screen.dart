import 'package:flutter/material.dart';
import 'package:flutter_agora_app/controllers/profile/profile_controller.dart';
import 'package:flutter_agora_app/widgets/text/auto_text.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AutoText("Profile"),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      controller.signOut();
                    },
                    child: AutoText("logout"))
              ],
            );
          },
        ),
      ),
    );
  }
}
