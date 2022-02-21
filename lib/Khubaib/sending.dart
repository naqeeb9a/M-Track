import 'package:courierapp/Khubaib/change_password.dart';
import 'package:courierapp/Khubaib/help_center.dart';
import 'package:courierapp/Khubaib/order_detail.dart';
import 'package:courierapp/Khubaib/order_screen.dart';
import 'package:courierapp/Khubaib/rating.dart';
import 'package:courierapp/Khubaib/submit_order.dart';
import 'package:courierapp/Khubaib/track_order.dart';
import 'package:courierapp/Screens/location.dart';
import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class SendingScreen extends StatefulWidget {
  const SendingScreen({Key? key}) : super(key: key);

  @override
  _SendingScreenState createState() => _SendingScreenState();
}

class _SendingScreenState extends State<SendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "What are you sending?"),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.article,
            "Documents",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.book,
            "Food or Meals",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.book,
            "Clothes",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.book,
            "Grocries",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.book,
            "Flowers",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.cake,
            "Cake",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
        ],
      ),
    );
  }
}
