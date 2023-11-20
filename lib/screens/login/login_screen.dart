import 'package:flutter/material.dart';
import 'package:flutter_agora_app/routes/routes.dart';
import 'package:flutter_agora_app/widgets/button/button_custom.dart';
import 'package:flutter_agora_app/widgets/loading/loading.dart';
import 'package:get/get.dart';
import '../../controllers/login/login_controller.dart';
import '../../widgets/text/auto_text.dart';
import '../../widgets/textfeild/textfeild_custom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff9f9f9),
          elevation: 0,
        ),
        body: Container(
            width: size.width,
            height: size.height,
            child: GetBuilder<LoginController>(
              init: LoginController(),
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.1),
                            AutoText(
                              "Login",
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                            TextFieldCustom(
                              title: "Email",
                              controller: controller.email,
                              padding: EdgeInsets.only(top: 60, bottom: 15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            TextFieldCustom(
                              title: "Password",
                              controller: controller.password,
                              padding: EdgeInsets.only(bottom: 20),
                              borderRadius: BorderRadius.circular(10),
                              hidePass: controller.hidePass,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.toggleHidePass();
                                },
                                icon: controller.hidePass
                                    ? Icon(Icons.visibility_off,
                                        color: Colors.black)
                                    : Icon(Icons.visibility,
                                        color: Colors.black),
                              ),
                            ),
                            ButtonCustom(
                              "login",
                              width: size.width,
                              height: 50,
                              onTap: () {
                                controller.login();
                              },
                              borderRadius: 10,
                              padding: EdgeInsets.only(bottom: 15),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.register);
                                },
                                child: AutoText("register",
                                    color: Colors.grey.shade500))
                          ],
                        ),
                      ),
                      LoadingPage(statusLoading: controller.statusLoading)
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
