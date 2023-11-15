import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/profile_controller.dart';
import '../../models/users/userData.dart';
import '../button/button_custom.dart';
import '../text/auto_text.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (UserData.user == null) {
            return Container();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoText(
                    UserData.user!.firstName,
                    fontSize: 20,
                  ),
                  SizedBox(width: 20),
                  AutoText(
                    UserData.user!.lastName,
                    fontSize: 20,
                  ),
                ],
              ),
              ButtonCustom(
                "Logout",
                onTap: () {
                  controller.signOut();
                },
                borderRadius: 5,
              )
            ],
          );
        },
      ),
    );
  }
}
