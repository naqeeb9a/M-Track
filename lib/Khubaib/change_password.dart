import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Widgets/colorful_button.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "Change Password"),
          CustomSizes().heightBox(context, 0.15),
          // registerInputField(context, "Write your current Password",password: true),
          // registerInputField(context, "Write New Password",password: true),
          // registerInputField(context, "Confirm Password",password: true),
          CustomSizes().heightBox(context, 0.05),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05)),
            child: colorfulButton(
              context,
              "Change Password",
              CustomColors.customYellow,
              CustomColors.customYellow,
              FontWeight.bold,
              // function: () {
              //   CustomRoutes().push(context, const TrackDetail());
              // },
            ),
          ),
        ],
      ),
    );
  }
}
