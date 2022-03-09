import 'dart:convert';

import 'package:http/http.dart' as http;

class UserAuthentication {
  loginUser(String email, String password) async {
    try {
      var res = await http
          .post(Uri.parse("http://mtrack.mtechtesting.com/api/login"), body: {
        "email": email,
        "password": password,
        "api_key": "loopmtrack3131a4cd22542b79134fe80f69f5b6ca",
        "api_secret": "mtrack9f7c4bb3946f029b56eebff3203cc5d5"
      });
      var jsonData = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return jsonData;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
