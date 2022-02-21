import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class TrackDetail extends StatefulWidget {
  const TrackDetail({Key? key}) : super(key: key);

  @override
  _TrackDetailState createState() => _TrackDetailState();
}

class _TrackDetailState extends State<TrackDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        topBar(context, "Track Order -12345"),
        CustomSizes().heightBox(context, 0.1),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CustomSizes().dynamicWidth(context, 0.05),
          ),
          child: Column(
            children: [
              rowtext(context, "Order Placed by Hassan Ali"),
              CustomSizes().heightBox(context, 0.05),
              rowtext(context, "Delivery Boy Assigned: Naqeeb Gujjar"),
              CustomSizes().heightBox(context, 0.05),
              rowtext(context, "Courier is Picked Up", colour: false),
              CustomSizes().heightBox(context, 0.05),
              rowtext(context, "Courier is on the way to Deliver Package",
                  colour: false),
              CustomSizes().heightBox(context, 0.05),
              rowtext(context, "Courier is Delivered", colour: false),
            ],
          ),
        ),
      ],
    ));
  }
}

Widget rowtext(context, title, {colour = true}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        Icons.circle_outlined,
        color: colour == true
            ? CustomColors.customYellow
            : CustomColors.customGrey,
        size: CustomSizes().dynamicHeight(context, 0.016),
      ),
      Flexible(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, 0.05)),
          child: text(
              context,
              title,
              0.035,
              colour == true
                  ? CustomColors.customLightBlack
                  : CustomColors.customGrey,
              bold: true),
        ),
      ),
    ],
  );
}
