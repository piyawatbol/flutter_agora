import 'package:flutter/material.dart';
import 'package:flutter_agora_app/services/apis/register/register_api.dart';
import 'package:flutter_agora_app/widgets/log_custom/log_custom.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool statusLoading = false;

  register() async {
    statusLoading = true;
    update();
    Map<String, dynamic> body = {
      "first_name": first_name.text,
      "last_name": last_name.text,
      "email": email.text,
      "password": password.text,
      "phone": phone.text,
      "login_type": "email_password",
    };
    final response = await RegisterApi.register(body);
    if (response['message'] == "Success") {
      LogShow.showLog(response);
      statusLoading = false;
      update();
      Get.back();
    } else {
      statusLoading = false;
      update();
    }
  }
}
