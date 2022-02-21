import 'package:courierapp/Khubaib/change_password.dart';
import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Screens/registration.dart';
import 'package:courierapp/Widgets/colorful_button.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(context, "Personal Details"),
          CustomSizes().heightBox(context, 0.09),
          registerInputField(context, "Last name"),
          registerInputField(context, "First name"),
          registerInputField(context, "Middle name"),
          registerInputField(context, "Mobile number"),
          registerInputField(context, "Email"),
          CustomSizes().heightBox(context, 0.05),
          InkWell(
            onTap: () => CustomRoutes().push(
              context,
              const ChangePassword(),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.05)),
              child: Text(
                'Change your Password',
                style: TextStyle(
                  fontSize: CustomSizes().dynamicHeight(context, 0.015),
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          CustomSizes().heightBox(context, 0.05),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05)),
            child: colorfulButton(
                context,
                "Register",
                CustomColors.customYellow,
                CustomColors.customYellow,
                FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
