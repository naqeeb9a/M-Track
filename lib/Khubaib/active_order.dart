import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class ActiveOrder extends StatefulWidget {
  const ActiveOrder({ Key? key }) : super(key: key);

  @override
  _ActiveOrderState createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        width: CustomSizes().dynamicWidth(context, 1),
        height: CustomSizes().dynamicHeight(context, 1),
        color: CustomColors.customGrey.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: CustomSizes().dynamicWidth(context, 0.85),
              height: CustomSizes().dynamicHeight(context, .15),
              // color: CustomColors.customWhite,
              decoration: BoxDecoration(
                color:CustomColors.customWhite,
                borderRadius: BorderRadius.circular(CustomSizes().dynamicWidth(context, 0.05),)
              ),

            ),
            CustomSizes().heightBox(context,0.05),
            Container(
              width: CustomSizes().dynamicWidth(context, 0.85),
              height: CustomSizes().dynamicHeight(context, .15),
              // color: CustomColors.customWhite,
              decoration: BoxDecoration(
                  color: CustomColors.customWhite,
                  borderRadius: BorderRadius.circular(
                    CustomSizes().dynamicWidth(context, 0.05),
                  )),
            )
          ],
        ),
      ),
    );
  }
}