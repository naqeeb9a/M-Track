import 'dart:convert';

import 'package:http/http.dart' as http;

class UserAuthentication {
  loginUser(String email, String password) async {
    try {
      var res = await http
          .post(Uri.parse("http://mtrack.mtechtesting.com/api/login"), body: {
        "email": email,
        "password": password,
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
