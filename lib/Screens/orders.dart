import 'package:courierapp/Routes/routes.dart';
import 'package:courierapp/Screens/home_page.dart';
import 'package:courierapp/Screens/registration.dart';
import 'package:courierapp/configs.dart/configs.dart';
import 'package:flutter/material.dart';

import '../DynamicSizes/dynamic_sizes.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: DynamicSize().dynamicHeigth(context, 0.2),
            color: themeColor,
          ),
          SafeArea(
            child: SizedBox(
              width: DynamicSize().dynamicWidth(context, 1),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DynamicSize().dynamicWidth(context, 0.05)),
                child: Column(
                  children: [
                    DynamicSize().heightBox(context, 0.02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: DynamicSize().dynamicWidth(context, 0.035),
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: DynamicSize().dynamicWidth(context, 0.03),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DynamicSize().heightBox(context, 0.03),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        DynamicSize()
                                            .dynamicWidth(context, 0.02)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(2, 4),
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 2,
                                          spreadRadius: 2)
                                    ]),
                                padding: EdgeInsets.all(
                                    DynamicSize().dynamicWidth(context, 0.06)),
                                child: Column(
                                  children: [
                                    DynamicSize().heightBox(context, 0.02),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Hello There",
                                          style: TextStyle(
                                              fontSize: DynamicSize()
                                                  .dynamicWidth(context, 0.04)),
                                        )),
                                    DynamicSize().heightBox(context, 0.03),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Login to your\nAccount!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: DynamicSize()
                                                  .dynamicWidth(context, 0.05)),
                                        )),
                                    DynamicSize().heightBox(context, 0.03),
                                    colorfulButton(context, "Login", themeColor,
                                        Colors.transparent, FontWeight.normal),
                                  ],
                                ),
                              ),
                              DynamicSize().heightBox(context, 0.17),
                              const Text("Don't Have an Account?"),
                              DynamicSize().heightBox(context, 0.02),
                              colorfulButton(
                                  context,
                                  "SignUp",
                                  Colors.transparent,
                                  themeColor,
                                  FontWeight.bold, function: () {
                                DynamicRoutes()
                                    .push(context, const Registration());
                              })
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: DynamicSize().dynamicWidth(context, 1),
              color: Colors.black.withOpacity(0.7),
              padding:
                  EdgeInsets.all(DynamicSize().dynamicHeigth(context, 0.03)),
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
                            color: themeColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                DynamicSize().dynamicWidth(context, 0.04)),
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
