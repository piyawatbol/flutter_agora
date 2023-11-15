import '../../../configs/ipcon.dart';
import '../../https/http_request.dart';

class RegisterApi {
  static register(body) async {
    final response = await HttpRequest.post('$ipcon/register', body: body);
    return response;
  }
}
