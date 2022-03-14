import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

Widget multiColorText(context, text, text1) {
  return Center(
    child: SizedBox(
      width: CustomSizes().dynamicWidth(context, 0.6),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: CustomSizes().dynamicWidth(context, 0.025))),
            TextSpan(
                text: text1,
                style: TextStyle(
                    color: CustomColors.customYellow,
                    fontWeight: FontWeight.bold,
                    fontSize: CustomSizes().dynamicWidth(context, 0.025))),
          ],
        ),
      ),
    ),
  );
}

Widget registerInputField(
    context, text1, TextEditingController controller, hintText,
    {bool password = false, bool enable = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding:
              EdgeInsets.only(left: CustomSizes().dynamicWidth(context, 0.05)),
          child:
              text(context, text1, 0.03, CustomColors.customGrey, bold: true)),
      TextFormField(
        controller: controller,
        enabled: enable,
        obscureText: password == true ? true : false,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: password == true
              ? const InkWell(
                  child: Icon(Icons.visibility_outlined),
                )
              : null,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.customYellow,
              width: CustomSizes().dynamicWidth(context, 0.0065),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, 0.05)),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.customGrey,
            ),
          ),
        ),
      ),
      CustomSizes().heightBox(context, 0.01),
    ],
  );
}
