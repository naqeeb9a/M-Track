import 'package:courierapp/Screens/change_password.dart';
import 'package:courierapp/Widgets/input_buttons.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Widgets/text_widget.dart';

class VerifyCode extends StatefulWidget {
  final String uniqueId, email;

  const VerifyCode({
    Key? key,
    required this.uniqueId,
    required this.email,
  }) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  final verifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: CustomSizes().dynamicWidth(context, 0.05)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                  onTap: () {
                    CustomRoutes().pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: CustomColors.customBlack,
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(context, "Verify Code", 0.07, CustomColors.customBlack,
                    bold: true),
                CustomSizes().heightBox(context, 0.02),
                text(
                    context,
                    "A Verify Code has been sent to your mail check and enter the verification code below",
                    0.03,
                    CustomColors.customBlack),
              ],
            ),
            RegisterInputField(
                context: context,
                text1: "Verfication Code",
                controller: verifyController,
                hintText: "Example : 0001"),
            RoundedLoadingButton(
              color: CustomColors.customYellow,
              controller: _buttonController,
              onPressed: () async {
                if (verifyController.text.isEmpty) {
                  _buttonController.reset();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: text(
                          context,
                          "Invalid OTP make sure it's not empty and is of 4 digits",
                          0.04,
                          CustomColors.customWhite)));
                } else {
                  var res = await RiderFunctionality()
                      .validateOTP(widget.uniqueId, verifyController.text);
                  if (res == "error") {
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "Wrong OTP Please enter the correct OTP",
                            0.04,
                            CustomColors.customWhite)));
                  } else if (res == false) {
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "check your internet and try again",
                            0.04,
                            CustomColors.customWhite)));
                  } else {
                    _buttonController.reset();
                    CustomRoutes().pop(context);
                    CustomRoutes().pop(context);
                    CustomRoutes()
                        .push(context, ChangePassword(email: widget.email));
                  }
                }
              },
              child: text(context, "Verify", 0.04, CustomColors.customBlack),
            )
          ],
        ),
      ),
    );
  }
}
