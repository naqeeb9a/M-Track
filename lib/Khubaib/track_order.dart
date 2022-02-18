import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Widgets/colorful_button.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "Track Order"),
          CustomSizes().heightBox(context, 0.05),
          trackTextField(context, "Enter Order Number"),
          CustomSizes().heightBox(context, 0.09),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05)),
            child: colorfulButton(context, "Submit", CustomColors.customYellow,
                CustomColors.customYellow, FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

Widget trackTextField(context, hintText, {border = true}) {
  return TextFormField(
    cursorColor: Colors.black,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: CustomColors.customGrey,
        fontSize: CustomSizes().dynamicHeight(context, 0.02),
        fontWeight: FontWeight.w500,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color:
              border == true ? CustomColors.customYellow : CustomColors.noColor,
          width: CustomSizes().dynamicWidth(context, .0065),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: CustomSizes().dynamicWidth(context, 0.05)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color:
              border == true ? CustomColors.customGrey : CustomColors.noColor,
          width: CustomSizes().dynamicWidth(context, .0065),
        ),
      ),
    ),
  );
}
