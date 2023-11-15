import 'package:flutter_agora_app/services/https/http_request.dart';

import '../../../configs/ipcon.dart';

class LoginApi {
  static Future login(body) async {
    var response = await HttpRequest.post('$ipcon/login', body: body);
    return response;
  }
}
