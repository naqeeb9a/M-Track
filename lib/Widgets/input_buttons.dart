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

class RegisterInputField extends StatefulWidget {
  final BuildContext context;
  final String text1, hintText;
  final TextEditingController controller;

  final bool password, enable;
  const RegisterInputField(
      {Key? key,
      required this.context,
      required this.text1,
      required this.hintText,
      required this.controller,
      this.password = false,
      this.enable = true})
      : super(key: key);

  @override
  State<RegisterInputField> createState() => _RegisterInputFieldState();
}

class _RegisterInputFieldState extends State<RegisterInputField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: CustomSizes().dynamicWidth(context, 0.05)),
            child: text(context, widget.text1, 0.03, CustomColors.customGrey,
                bold: true)),
        TextFormField(
          controller: widget.controller,
          enabled: widget.enable,
          obscureText: widget.password == true ? isVisible : false,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.password == true
                ? InkWell(
                    onTap: () {
                      if (isVisible == true) {
                        setState(() {
                          isVisible = false;
                        });
                      } else {
                        setState(() {
                          isVisible = true;
                        });
                      }
                    },
                    child: const Icon(Icons.visibility_outlined),
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
}
