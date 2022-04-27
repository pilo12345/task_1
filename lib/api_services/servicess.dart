import 'package:http/http.dart' as http;
import 'package:task_1/api_routes/service.dart';
import 'package:task_1/constant.dart';
import 'package:task_1/model/doctor_detail_mdel.dart';

class FireBaseAuthService {
  static Future<bool> getData({String? email, String? password}) async {
    await kfirebase.createUserWithEmailAndPassword(
        email: email!, password: password!);

    return true;
  }
}

class ApiBaseService {
  static Future<Detail> getData() async {
    http.Response response = await http.get(Uri.parse(ApiRoutes.doctor));

    return detailFromJson(response.body);
  }
}
