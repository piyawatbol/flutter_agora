import 'package:flutter/material.dart';
import 'package:flutter_agora_app/controllers/resgister/register_controller.dart';
import 'package:flutter_agora_app/widgets/button/button_custom.dart';
import 'package:flutter_agora_app/widgets/loading/loading.dart';
import 'package:get/get.dart';

import '../../widgets/text/auto_text.dart';
import '../../widgets/textfeild/textfeild_custom.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xfff9f9f9),
        elevation: 0,
      ),
      body: Container(
          width: size.width,
          height: size.height,
          child: GetBuilder<RegisterController>(
            init: RegisterController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        AutoText(
                          "Register",
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 30),
                        TextFieldCustom(
                          title: "Firstname",
                          controller: controller.first_name,
                          padding: EdgeInsets.only(bottom: 10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        TextFieldCustom(
                          title: "Lastname",
                          controller: controller.last_name,
                          padding: EdgeInsets.only(bottom: 10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        TextFieldCustom(
                          title: "Phone",
                          controller: controller.phone,
                          padding: EdgeInsets.only(bottom: 10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        TextFieldCustom(
                          title: "Email",
                          controller: controller.email,
                          padding: EdgeInsets.only(bottom: 10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        TextFieldCustom(
                          title: "Password",
                          controller: controller.password,
                          padding: EdgeInsets.only(bottom: 10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        ButtonCustom(
                          "register",
                          onTap: () {
                            controller.register();
                          },
                          width: size.width,
                          height: 50,
                          padding: EdgeInsets.only(top: 20),
                          borderRadius: 10,
                        )
                      ],
                    ),
                    LoadingPage(statusLoading: controller.statusLoading)
                  ],
                ),
              );
            },
          )),
    );
  }
}
