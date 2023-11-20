import 'package:flutter_agora_app/services/https/http_request.dart';
import '../../../configs/ipcon.dart';

class LiveApi {
  static Future getLive() async {
    final response =
        await HttpRequest.get("$ipcon/get_live", withAccessToken: true);
    return response;
  }

  static Future addLive(body) async {
    final response = await HttpRequest.postImage("$ipcon/add_live",
        body: body, withAccessToken: true);
    return response;
  }

  static Future deleteLive(body) async {
    final response = await HttpRequest.delete("$ipcon/delete_live",
        body: body, withAccessToken: true);
    return response;
  }
}
