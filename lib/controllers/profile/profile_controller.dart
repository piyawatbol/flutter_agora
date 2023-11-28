import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/users/userData.dart';
import '../../models/users/user_model.dart';
import '../../routes/routes.dart';
import '../../services/apis/profile/profile_api.dart';

class ProfileController extends GetxController {
  String? token;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  getProfile() async {
    final response = await ProfileApi.getProfile();
    if (response['message'] == "Success") {
      UserData.user = UserModel.fromJson(response['data']['data']);
      update();
    }
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Get.offAllNamed(AppRoutes.login);
    update();
  }
}
