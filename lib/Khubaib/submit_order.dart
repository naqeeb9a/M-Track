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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(context, "Submit Order"),
          CustomSizes().heightBox(context, 0.04),
          text(context, "     What`s in it :Document", 0.045,
              CustomColors.customBlack,
              bold: true),
          text(context, "     Up to 5 kg, book a courier", 0.035,
              CustomColors.customLightBlack,
              bold: true),
          CustomSizes().heightBox(context, 0.02),
          text(context, "     Stated value : \$470", 0.035,
              CustomColors.customGrey,
              bold: true),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: CustomSizes().dynamicHeight(context, 0.02)),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return orderCard(context, index);
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget orderCard(context, index) {
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: CustomSizes().dynamicHeight(context, 0.01)),
    padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.05),
        vertical: CustomSizes().dynamicWidth(context, 0.05)),
    color: CustomColors.customWhite,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: CustomSizes().dynamicWidth(context, 0.05),
          backgroundColor: CustomColors.customYellow,
          child: text(
              context, (index + 1).toString(), 0.045, CustomColors.customWhite),
        ),
        SizedBox(
          width: CustomSizes().dynamicWidth(context, 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                  context,
                  "IQBAL SPEAKERS WORKS Office, Shahrah-e-Quaid-e-Azam, opposite State Bank, Lahore, 56000",
                  0.04,
                  CustomColors.customLightBlack,
                  bold: true,
                  maxLines: 5),
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
  );
}

Widget orderBottomBar(context) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 0.06),
    padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.05)),
    color: CustomColors.customLightBlack,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(context, "\$1300", 0.038, CustomColors.customYellow, bold: true),
        Row(children: [
          text(context, "Created", 0.038, CustomColors.customWhite, bold: true),
          Icon(Icons.arrow_forward_ios,
              size: CustomSizes().dynamicWidth(context, 0.035),
              color: CustomColors.customWhite),
        ])
      ],
    ),
  );
}
