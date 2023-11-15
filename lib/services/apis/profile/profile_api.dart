import '../../../configs/ipcon.dart';
import '../../https/http_request.dart';

class ProfileApi {
  static Future getProfile() async {
    final response =
        await HttpRequest.get('$ipcon/get_user', withAccessToken: true);
    return response;
  }
}
