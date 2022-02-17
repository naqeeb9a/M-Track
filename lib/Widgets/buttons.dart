import 'package:courierapp/DynamicSizes/dynamic_sizes.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../configs.dart/configs.dart';

Widget coloredButton(context, text, color,
    {function = "", width = "", fontSize = 0.04, fontColor = true}) {
  return GestureDetector(
    onTap: function == "" ? () {} : function,
    child: Container(
      width: width == "" ? DynamicSize().dynamicWidth(context, 1) : width,
      height: DynamicSize().dynamicWidth(context, .12),
      decoration: color == CustomColors.noColor
          ? BoxDecoration(
              color: color,
              border: Border.all(width: 1, color: CustomColors.customWhite),
            )
          : BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                DynamicSize().dynamicWidth(
                  context,
                  1,
                ),
              ),
            ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: fontColor == true
                ? CustomColors.customWhite
                : CustomColors.customBlack,
            fontWeight: FontWeight.bold,
            fontSize: DynamicSize().dynamicWidth(context, fontSize),
          ),
        ),
      ),
    ),
  );
}

Widget retry(context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // LottieBuilder.asset(
        //   "assets/retry.json",
        //   width: dynamicWidth(context, 0.4),
        //   repeat: false,
        // ),
        DynamicSize().heightBox(context, 0.02),
        text(context, "Check your internet or try again later", 0.03,
            CustomColors.customWhite),
        DynamicSize().heightBox(context, 0.1),
        coloredButton(
          context,
          "Retry",
          CustomColors.customPink,
          width: DynamicSize().dynamicWidth(context, .4),
          function: () {},
        ),
      ],
    ),
  );
}
