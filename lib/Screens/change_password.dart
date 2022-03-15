import 'package:courierapp/Widgets/input_buttons.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Widgets/text_widget.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  final bool changePasswordScreen;
  const ChangePassword({
    Key? key,
    required this.email,
    this.changePasswordScreen = false,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  bool enable = true;

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
                text(context, "Change password", 0.07, CustomColors.customBlack,
                    bold: true),
                CustomSizes().heightBox(context, 0.02),
                text(
                    context,
                    "You have to enter your current password and then set a new password",
                    0.03,
                    CustomColors.customBlack),
              ],
            ),
            Column(
              children: [
                Visibility(
                  visible: widget.changePasswordScreen,
                  child: RegisterInputField(
                      context: context,
                      text1: "Current Password",
                      controller: currentPassword,
                      hintText: "Enter your current password",
                      password: true,
                      enable: enable),
                ),
                const SizedBox(
                  height: 5,
                ),
                RegisterInputField(
                    context: context,
                    text1: "New Password",
                    controller: newPassword,
                    hintText: "Enter your new password",
                    password: true,
                    enable: enable),
                const SizedBox(
                  height: 5,
                ),
                RegisterInputField(
                    context: context,
                    text1: "Confirm New Password",
                    controller: confirmPassword,
                    hintText: "Confirm your new password",
                    password: true,
                    enable: enable),
              ],
            ),
            RoundedLoadingButton(
              color: CustomColors.customYellow,
              controller: _buttonController,
              onPressed: () async {
                setState(() {
                  enable = false;
                });
                if (widget.changePasswordScreen == true) {
                  if (newPassword.text.isEmpty ||
                      confirmPassword.text.isEmpty ||
                      currentPassword.text.isEmpty) {
                    setState(() {
                      enable = true;
                    });
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "Password fields cannot be empty",
                            0.04,
                            CustomColors.customWhite)));
                  } else if (newPassword.text != confirmPassword.text) {
                    setState(() {
                      enable = true;
                    });
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(context, "Both passwords are not same",
                            0.04, CustomColors.customWhite)));
                  } else if (newPassword.text.length < 6) {
                    setState(() {
                      enable = true;
                    });
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "password cannot be less than 6 characters",
                            0.04,
                            CustomColors.customWhite)));
                  } else {
                    var res = await RiderFunctionality().changePassword(
                        widget.email, currentPassword.text, newPassword.text);
                    if (res == false) {
                      setState(() {
                        enable = true;
                      });
                      _buttonController.reset();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: text(context, "check your internet", 0.04,
                              CustomColors.customWhite)));
                    } else {
                      setState(() {
                        enable = true;
                      });
                      _buttonController.reset();
                      CustomRoutes().pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: text(
                              context,
                              "Successfully changed password",
                              0.04,
                              CustomColors.customWhite)));
                    }
                  }
                } else {
                  if (newPassword.text.isEmpty ||
                      confirmPassword.text.isEmpty) {
                    setState(() {
                      enable = true;
                    });
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "Password fields cannot be empty",
                            0.04,
                            CustomColors.customWhite)));
                  } else if (newPassword.text != confirmPassword.text) {
                    setState(() {
                      enable = true;
                    });
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(context, "Both passwords are not same",
                            0.04, CustomColors.customWhite)));
                  } else if (newPassword.text.length < 6) {
                    setState(() {
                      enable = true;
                    });
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "password cannot be less than 6 characters",
                            0.04,
                            CustomColors.customWhite)));
                  } else {
                    var res = await RiderFunctionality().resetPassword(
                        widget.email, newPassword.text, confirmPassword.text);
                    if (res == false) {
                      setState(() {
                        enable = true;
                      });
                      _buttonController.reset();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: text(context, "check your internet", 0.04,
                              CustomColors.customWhite)));
                    } else {
                      setState(() {
                        enable = true;
                      });
                      _buttonController.reset();
                      CustomRoutes().pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: text(
                              context,
                              "successfully reset password login with your new password",
                              0.04,
                              CustomColors.customWhite)));
                    }
                  }
                }
              },
              child: text(context, "Change", 0.04, CustomColors.customBlack),
            )
          ],
        ),
      ),
    );
  }
}
