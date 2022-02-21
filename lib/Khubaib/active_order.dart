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
      body: activeOrder(context),
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
        noactiveOrderCard(
            context,
            "https://www.pngkit.com/png/full/72-724560_png-file-tracking-parcel-png.png",
            "Send Package",
            "Deliver or recieve items such as gifts ,documents,keys",
            CustomColors.customYellow),
        CustomSizes().heightBox(context, 0.065),
        noactiveOrderCard(
            context,
            "https://cdn0.iconfinder.com/data/icons/line-design-word-processing-set-3-1/21/mailing-recipient-list-512.png",
            "I am Recipent",
            "Track an incoming delivery in the app",
            CustomColors.customBlack)
      ],
    ),
  );
}

Widget noactiveOrderCard(context, image, title, subtitle, pngColor) {
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

Widget activeOrder(context) {
  return SizedBox(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 1),
    child: ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: CustomSizes().dynamicHeight(context, 0),
      ),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return activeOrderCard(context);
      },
    ),
  );
}

Widget activeOrderCard(context){
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 0.24),
    padding: EdgeInsets.symmetric(
      horizontal: CustomSizes().dynamicWidth(context, 0.05),
      vertical: CustomSizes().dynamicHeight(context, 0.01),
    ),
    decoration: const BoxDecoration(
      border: Border(bottom : BorderSide(color:CustomColors.customGrey))
    ),
    child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text(context, "\$370", 0.04, CustomColors.customBlack, bold: true),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.01),
              ),
              decoration: BoxDecoration(
                color: CustomColors.customGrey,
                borderRadius: BorderRadius.circular(
                  CustomSizes().dynamicWidth(context, 0.05),
                ),
              ),
              child: text(context, "14325", 0.03, CustomColors.customBlack),
            )
          ],
        ),
        text(context, "Courier is on the way", 0.035, CustomColors.customGreen,
            bold: true),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
      
          children: [
            Icon(Icons.circle_outlined,color:CustomColors.customYellow,size:CustomSizes().dynamicHeight(context, 0.015),),
             Flexible(
               child: Padding(
                 padding:  EdgeInsets.symmetric(horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                 child: text(
                    context,
                    "18C, Block D Block Q Gulberg 2, Lahore, Punjab",
                    0.035,
                    CustomColors.customLightBlack,
                    bold: true),
               ),
             ),
          ],
        ),
       
         Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           
          children: [
            Icon(
              Icons.circle_outlined,
              color: CustomColors.customYellow,
              size:CustomSizes().dynamicHeight(context, 0.015),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                child: text(
                    context,
                    "Address 73, 73 Street L, Block L Gulberg III, Lahore, Punjab",
                    0.035,
                    CustomColors.customLightBlack,
                    bold: true),
              ),
            ),
          ],
        ),
        CustomSizes().heightBox(context, 0.02)
      ],
    ),
  );
}