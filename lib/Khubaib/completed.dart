import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class CompletedOrder extends StatefulWidget {
  const CompletedOrder({Key? key}) : super(key: key);

  @override
  _CompletedOrderState createState() => _CompletedOrderState();
}

class _CompletedOrderState extends State<CompletedOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: CustomSizes().dynamicWidth(context, 1),
        height: CustomSizes().dynamicHeight(context, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            text(
                context, "Complete order", 0.05, CustomColors.customBlack)
          ],
        ),
      ),
    );
  }
}
