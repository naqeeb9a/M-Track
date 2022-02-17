import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';


class SubmitOrder extends StatefulWidget {
  const SubmitOrder({Key? key}) : super(key: key);

  @override
  _SubmitOrderState createState() => _SubmitOrderState();
}

class _SubmitOrderState extends State<SubmitOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: orderBottomBar(context),
      body: Column(
        children: [
          topBar(context, "Submit Order"),
          Padding(
            padding: EdgeInsets.only(
              left: CustomSizes().dynamicWidth(context, 0.05),
              top: CustomSizes().dynamicHeight(context, 0.025),
              right: CustomSizes().dynamicWidth(context, 0.05),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(context, "What`s in it :Document", 0.045,
                    CustomColors.customBlack,
                    bold: true),
                text(context, "Up to 5 kg, book a courier", 0.035,
                    CustomColors.customLightBlack,
                    bold: true),
                CustomSizes().heightBox(context, 0.02),
                Row(
                  children: [
                    text(context, "Stated value :", 0.035,
                        CustomColors.customGrey,
                        bold: true),
                    text(context, "\$470", 0.035, CustomColors.customBlack,
                        bold: true),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Expanded(
              child: SizedBox(
                width: CustomSizes().dynamicWidth(context, 1),
                height: CustomSizes().dynamicHeight(context, 0.65),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return orderCard(context, index);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget orderCard(context, index) {
  return Padding(
    padding:
        EdgeInsets.only(bottom: CustomSizes().dynamicHeight(context, 0.01)),
    child: Container(
      width: CustomSizes().dynamicWidth(context, 1),
      height: CustomSizes().dynamicHeight(context, .2),
      padding: EdgeInsets.symmetric(
          horizontal: CustomSizes().dynamicWidth(context, 0.05),
          vertical: CustomSizes().dynamicHeight(context, 0.025)),
      color: CustomColors.customWhite,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: CustomSizes().dynamicWidth(context, 0.18),
                height: CustomSizes().dynamicHeight(context, 0.15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: CustomSizes().dynamicWidth(context, 0.05),
                      backgroundColor: CustomColors.customYellow,
                      child: text(context, (index + 1).toString(), 0.045,
                          CustomColors.customWhite),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.03),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                        context,
                        "IQBAL SPEAKERS WORKS Office,\n Shahrah-e-Quaid-e-Azam,\n opposite State Bank, Lahore, 56000",
                        0.04,
                        CustomColors.customLightBlack,
                        bold: true,
                        maxLines: 3),
                    CustomSizes().heightBox(context, 0.01),
                    text(context, "Today till:11.30", 0.04,
                        CustomColors.customLightBlack,
                        bold: true),
                    text(context, "+92324 4441990", 0.04,
                        CustomColors.customLightBlack,
                        bold: true),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


Widget orderBottomBar(context) {
  return Container(
        width: CustomSizes().dynamicWidth(context, 1),
        height: CustomSizes().dynamicHeight(context, 0.06),
        padding: EdgeInsets.symmetric(horizontal: CustomSizes().dynamicWidth(context, 0.05)),
        color: CustomColors.customLightBlack,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        text(context, "\$1300",0.038, CustomColors.customYellow,bold: true),
        Row(
          children:[
            text(context, "Created", 0.038, CustomColors.customWhite,bold:true),
            Icon(Icons.arrow_forward_ios,size: CustomSizes().dynamicWidth(context, 0.035),color:CustomColors.customWhite),
          ]
        )
          ],
        ),
      );
}