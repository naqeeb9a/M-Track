import 'package:courierapp/Khubaib/order_screen.dart';
import 'package:courierapp/Khubaib/rating.dart';
import 'package:courierapp/Khubaib/submit_order.dart';
import 'package:courierapp/Khubaib/track_order.dart';
import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class SendingScreen extends StatefulWidget {
  const SendingScreen({ Key? key }) : super(key: key);

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
          InkWell(
            onTap: () => CustomRoutes().push(context, const SubmitOrder()),
            child: cards(context, Icons.article, "Documents", false),
          ),
          CustomSizes().heightBox(context, 0.02),
           InkWell(
            onTap: () => CustomRoutes().push(context, const RatingScreen()),
            child: cards(context, Icons.book, "Food or Meals", false),
          ),
          CustomSizes().heightBox(context, 0.02),
           InkWell(
            onTap: () => CustomRoutes().push(context, const TrackOrder()),
            child:  cards(context, Icons.book, "Clothes", false),
          ),
          CustomSizes().heightBox(context, 0.02),
           InkWell(
            onTap: () => CustomRoutes().push(context, const OrderScreen()),
            child: cards(context, Icons.book, "Grocries", false),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(context, Icons.book, "Flowers", false),
          CustomSizes().heightBox(context, 0.02),
          cards(context, Icons.cake ,"Cake", false),
         
        ],
      ),
    );
  }
}