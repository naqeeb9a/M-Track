import 'package:courierapp/Screens/home_page.dart';
import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/configs.dart/configs.dart';
import 'package:flutter/material.dart';

import '../DynamicSizes/dynamic_sizes.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.92,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topBar(context, "Registration"),
                DynamicSize().heightBox(context, 0.05),
                Padding(
                  padding: EdgeInsets.only(
                      left: DynamicSize().dynamicWidth(context, 0.05)),
                  child: Text(
                    "Let's Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: DynamicSize().dynamicWidth(context, 0.05),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: DynamicSize().dynamicWidth(context, 0.05)),
                  child: Text(
                    "Fill the form to Create your new account",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: DynamicSize().dynamicWidth(context, 0.03),
                    ),
                  ),
                ),
                DynamicSize().heightBox(context, 0.05),
                registerInputField(context, "First name"),
                registerInputField(context, "Last name"),
                registerInputField(context, "Email"),
                registerInputField(context, "Password"),
                registerInputField(context, "Mobile number"),
                DynamicSize().heightBox(context, 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DynamicSize().dynamicWidth(context, 0.05)),
                  child: colorfulButton(context, "Register", themeColor,
                      themeColor, FontWeight.bold),
                ),
                DynamicSize().heightBox(context, 0.02),
                multiColorText(context, "By clicking Register I agree with ",
                    "terms, Conditions and Agreements"),
                DynamicSize().heightBox(context, 0.02),
              ],
            ),
          ),
        ));
  }
}

Widget multiColorText(context, text, text1) {
  return Center(
    child: SizedBox(
      width: DynamicSize().dynamicWidth(context, 0.6),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: DynamicSize().dynamicWidth(context, 0.025))),
            TextSpan(
                text: text1,
                style: TextStyle(
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: DynamicSize().dynamicWidth(context, 0.025))),
          ])),
    ),
  );
}

Widget registerInputField(context, text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding:
            EdgeInsets.only(left: DynamicSize().dynamicWidth(context, 0.05)),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.grey,
              fontSize: DynamicSize().dynamicWidth(context, 0.03)),
        ),
      ),
      TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: DynamicSize().dynamicWidth(context, 0.05)),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.black.withOpacity(0.1))))),
      DynamicSize().heightBox(context, 0.01),
    ],
  );
}
