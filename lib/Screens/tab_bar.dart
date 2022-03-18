import 'package:courierapp/Khubaib/order_screen.dart';
import 'package:courierapp/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  double iconSize = 0.05;
  bool _loading = true;

  @override
  void initState() {
    checkLoginStatus(
      context,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading == true
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()))
        : const Scaffold(body: OrderScreen());
  }

  checkLoginStatus(
    BuildContext context,
  ) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    if (userData.getString("user") == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      setState(() {
        _loading = false;
      });
    }
  }
}
