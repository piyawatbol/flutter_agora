import 'package:flutter/material.dart';
import 'package:flutter_agora_app/widgets/log_custom/log_custom.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/https/http_request.dart';
import '../../widgets/setstatus/setstatus.dart';

class SplashController extends GetxController {
  String? token;
  String? role;

  @override
  void onInit() {
    Status.setStatus(Brightness.light);
    checkToken();
    super.onInit();
  }

  checkToken() async {
    token = await HttpRequest.getToken();
    LogShow.showLog("token : $token");
    update();
    if (token != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      role = preferences.getString('role');
    }
  }
}
