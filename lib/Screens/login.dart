import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Screens/registration.dart';
import 'package:courierapp/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/colorful_button.dart';
import '../utils/dynamic_sizes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "Login"),
          CustomSizes().heightBox(context, 0.1),
          LottieBuilder.asset(
            "assets/rider.json",
            controller: _controller,
            width: CustomSizes().dynamicWidth(context, 0.8),
          ),
          CustomSizes().heightBox(context, 0.1),
          registerInputField(context, "Email"),
          CustomSizes().heightBox(context, 0.03),
          registerInputField(context, "Password"),
          CustomSizes().heightBox(context, 0.3),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05)),
            child: colorfulButton(
                context,
                "Register",
                CustomColors.customYellow,
                CustomColors.customYellow,
                FontWeight.bold, function: () {
              _controller.forward().then((value) => _controller.reset());
            }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
