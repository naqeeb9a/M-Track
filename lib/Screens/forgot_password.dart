import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Screens/verification_screen.dart';

import 'package:courierapp/Widgets/input_buttons.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  final TextEditingController email = TextEditingController();
  bool enable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          text1: "Forgot Password",
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customYellow),
      backgroundColor: CustomColors.customWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: CustomSizes().dynamicWidth(context, 0.05)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LottieBuilder.asset(
              "assets/rider.json",
              width: CustomSizes().dynamicWidth(context, 0.6),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                    context, "Forgot password:", 0.04, CustomColors.customBlack,
                    bold: true),
                CustomSizes().heightBox(context, 0.02),
                text(
                    context,
                    "A reset password mail will be sent to your Entered email",
                    0.04,
                    CustomColors.customBlack),
              ],
            ),
            registerInputField(context, "Email", email, "Enter your email",
                enable: enable),
            RoundedLoadingButton(
              color: CustomColors.customYellow,
              controller: _buttonController,
              onPressed: () async {
                setState(() {
                  enable = false;
                });
                if (!email.text.contains("@") || !email.text.contains(".")) {
                  setState(() {
                    enable = true;
                  });
                  _buttonController.reset();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: text(context, "Enter a valid email", 0.04,
                          CustomColors.customWhite)));
                } else {
                  var res = await RiderFunctionality().requestOtp(email.text);

                  if (res == false) {
                    setState(() {
                      enable = true;
                    });
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "Enter Email that exists or check your internet connection",
                            0.04,
                            CustomColors.customWhite)));
                  } else {
                    setState(() {
                      enable = true;
                    });
                    _buttonController.reset();
                    CustomRoutes().push(
                        context,
                        VerifyCode(
                          email:email.text,
                          uniqueId: res,
                        ));
                  }
                }
              },
              child: text(context, "Send", 0.04, CustomColors.customBlack),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
