import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/routes.dart';
import '../../services/apis/login/login_api.dart';
import '../../widgets/log_custom/log_custom.dart';
import '../../widgets/setstatus/setstatus.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hidePass = true;
  bool statusLoading = false;

  @override
  void onInit() {
    Status.setStatus(Brightness.light);
    update();
    super.onInit();
  }

  login() async {
    statusLoading = true;
    update();
    Map<String, dynamic> body = {
      "email": email.text,
      "password": password.text,
      "login_type": "email_password"
    };
    final response = await LoginApi.login(body);
    if (response['message'] == "Success") {
      LogShow.showLog(response);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("token", response['data']['token'].toString());
      preferences.setString("role", response['data']['role'].toString());

      statusLoading = false;
      update();
      print(response['data']['role']);
      if (response['data']['role'] == 'user') {
        Get.offAllNamed(AppRoutes.home_viewer);
      } else if (response['data']['role'] == 'broadcaster') {
        Get.offAllNamed(AppRoutes.broadcaster);
      }
    } else {
      statusLoading = false;
      update();
    }
  }

  toggleHidePass() {
    hidePass = !hidePass;
    update();
  }
}
