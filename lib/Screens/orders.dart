import 'package:courierapp/Routes/routes.dart';
import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Screens/new_orders.dart';

import 'package:courierapp/Screens/registration.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

import '../Widgets/colorful_button.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: CustomSizes().dynamicHeight(context, 0.2),
            color: CustomColors.customYellow,
          ),
          SizedBox(
            width: CustomSizes().dynamicWidth(context, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.05)),
              child: Column(
                children: [
                  CustomSizes().heightBox(context, 0.02),
                  topBar(context, ""),
                  CustomSizes().heightBox(context, 0.03),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                CustomSizes().dynamicWidth(context, 0.02)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(2, 4),
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 2,
                                  spreadRadius: 2)
                            ]),
                        padding: EdgeInsets.all(
                            CustomSizes().dynamicWidth(context, 0.06)),
                        child: Column(
                          children: [
                            CustomSizes().heightBox(context, 0.02),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Hello There",
                                  style: TextStyle(
                                      fontSize: CustomSizes()
                                          .dynamicWidth(context, 0.04)),
                                )),
                            CustomSizes().heightBox(context, 0.03),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Login to your\nAccount!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: CustomSizes()
                                          .dynamicWidth(context, 0.05)),
                                )),
                            CustomSizes().heightBox(context, 0.03),
                            colorfulButton(
                                context,
                                "Login",
                                CustomColors.customYellow,
                                Colors.transparent,
                                FontWeight.normal, function: () {
                              DynamicRoutes().push(context, const Login());
                            }),
                          ],
                        ),
                      ),
                      CustomSizes().heightBox(context, 0.3),
                      const Text("Don't Have an Account?"),
                      CustomSizes().heightBox(context, 0.02),
                      colorfulButton(
                          context,
                          "SignUp",
                          Colors.transparent,
                          CustomColors.customYellow,
                          FontWeight.bold, function: () {
                        DynamicRoutes().push(context, const Registration());
                      })
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: CustomSizes().dynamicWidth(context, 1),
              color: Colors.black.withOpacity(0.7),
              padding:
                  EdgeInsets.all(CustomSizes().dynamicHeight(context, 0.03)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.transparent,
                  ),
                  Column(
                    children: [
                      Text(
                        "Create Order",
                        style: TextStyle(
                            color: CustomColors.customYellow,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                CustomSizes().dynamicWidth(context, 0.04)),
                      ),
                      const Text(
                        "Order with no registration",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
