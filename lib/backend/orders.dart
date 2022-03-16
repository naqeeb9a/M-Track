import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RiderFunctionality {
  getRiderPickUpCenters(query) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.get(
          Uri.parse("http://mtrack.mtechtesting.com/api/$query"),
          headers: {"Authorization": "Bearer ${riderData["token"]}"});
      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return jsonData["data"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  setOrderStatus(query, trackingNumber, status, {img = "", reason = ""}) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.post(
          Uri.parse("http://mtrack.mtechtesting.com/api/$query"),
          headers: {
            "Authorization": "Bearer ${riderData["token"]}",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "tracking_number": trackingNumber,
            "status": status,
            "reason": reason,
            "house_pic": img == "" ? "" : img
          }));
      var jsonData = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return img == "" ? jsonData["message"] : jsonData;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  deliverOrderStatus(
    query,
    trackingNumber,
    status,
    signature,
    paymentMethod,
  ) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.post(
          Uri.parse("http://mtrack.mtechtesting.com/api/$query"),
          headers: {
            "Authorization": "Bearer ${riderData["token"]}",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "tracking_number": trackingNumber,
            "status": status,
            "signature": signature,
            "payment_method": paymentMethod
          }));
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

  getRiderInfo({required String query}) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.get(
          Uri.parse("http://mtrack.mtechtesting.com/api/$query"),
          headers: {"Authorization": "Bearer ${riderData["token"]}"});
      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return jsonData["orders"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  riderOnline({required String query, required bool isActive}) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.post(
          Uri.parse("http://mtrack.mtechtesting.com/api/$query"),
          headers: {
            "Authorization": "Bearer ${riderData["token"]}",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"is_active": isActive}));
      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return jsonData["message"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  requestOtp(String email) async {
    try {
      var res = await http.post(
          Uri.parse("http://mtrack.mtechtesting.com/api/otp-request"),
          body: {
            "email": email,
          });
      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return jsonData["data"]["uniqueId"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  validateOTP(uniqueId, otp) async {
    try {
      var res = await http.post(
          Uri.parse("http://mtrack.mtechtesting.com/api/otp-validate"),
          body: {
            "uniqueId": uniqueId,
            "otp": otp,
          });
      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return jsonData;
      } else if (res.statusCode == 401) {
        return "error";
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  resetPassword(String email, String password, String cPassword) async {
    try {
      var res = await http.post(
          Uri.parse("http://mtrack.mtechtesting.com/api/rider-password-reset"),
          body: {
            "email": email,
            "new_password": password,
            "c_password": cPassword
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

  changePassword(String email, String password, String cPassword) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.post(
          Uri.parse("http://mtrack.mtechtesting.com/api/changePassword"),
          body: {
            "email": email,
            "current-password": cPassword,
            "new_password": password
          },
          headers: {
            "Authorization": "Bearer ${riderData["token"]}",
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

  sendLiveLocation(lat, lng, orderId) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.post(
          Uri.parse("http://mtrack.mtechtesting.com/api/track-location-rider"),
          headers: {
            "Authorization": "Bearer ${riderData["token"]}",
          },
          body: {
            "rider_id": riderData["data"]["id"].toString(),
            "order_id": orderId.toString(),
            "lat": lat.toString(),
            "lng": lng.toString()
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
