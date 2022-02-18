import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class ActiveOrder extends StatefulWidget {
  const ActiveOrder({Key? key}) : super(key: key);

  @override
  _ActiveOrderState createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: noActiverOrder(context),
    );
  }
}

Widget noActiverOrder(context) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 1),
    color: CustomColors.customGrey.withOpacity(0.2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        orderCard(
            context,
            "https://www.pngkit.com/png/full/72-724560_png-file-tracking-parcel-png.png",
            "Send Package",
            "Deliver or recieve items such as gifts ,documents,keys",
            CustomColors.customYellow),
        CustomSizes().heightBox(context, 0.065),
        orderCard(
            context,
            "https://cdn0.iconfinder.com/data/icons/line-design-word-processing-set-3-1/21/mailing-recipient-list-512.png",
            "I am Recipent",
            "Track an incoming delivery in the app",
            CustomColors.customBlack)
      ],
    ),
  );
}

Widget orderCard(context, image, title, subtitle, pngColor) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 0.85),
    height: CustomSizes().dynamicHeight(context, .15),
    decoration: BoxDecoration(
      color: CustomColors.customWhite,
      borderRadius: BorderRadius.circular(
        CustomSizes().dynamicWidth(context, 0.05),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: CustomSizes().dynamicWidth(context, 0.3),
          height: CustomSizes().dynamicHeight(context, .1),
          child: Image.network(
            image,
            color: pngColor,
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(context, title, 0.045, CustomColors.customBlack, bold: true),
              CustomSizes().heightBox(context, 0.02),
              text(context, subtitle, 0.035, CustomColors.customGrey),
            ],
          ),
        )
      ],
    ),
  );
}
