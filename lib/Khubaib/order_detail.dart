import 'package:courierapp/Khubaib/rating.dart';
import 'package:courierapp/Khubaib/submit_order.dart';
import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(context, "Order 12345"),
          CustomSizes().heightBox(context, 0.05),
          personCard(context, phoneIcon: true, containerColor: false),
          CustomSizes().heightBox(context, 0.05),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, .05),
            ),
            child: text(context, "Info", 0.035, CustomColors.customGrey,
                bold: true),
          ),
          CustomSizes().heightBox(context, 0.025),
          orderBox(context, "Created", "28.09.2021 13.54"),
          CustomSizes().heightBox(context, 0.025),
          orderBox(context, "Weight", "Up to 10kg"),
          CustomSizes().heightBox(context, 0.025),
          orderBox(context, "Delivery Method", "Public transport"),
          CustomSizes().heightBox(context, 0.025),
          orderBox(context, "Comments", "test"),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: CustomSizes().dynamicHeight(context, 0)),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return orderCard(context, index,icon: true);
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget orderBox(context, title, title1) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 0.06),
    padding: EdgeInsets.symmetric(
      horizontal: CustomSizes().dynamicWidth(context, .05),
    ),
    color: CustomColors.customWhite,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(context, title, 0.035, CustomColors.customGrey, bold: true),
        text(context, title1, 0.035, CustomColors.customLightBlack, bold: true),
      ],
    ),
  );
}
