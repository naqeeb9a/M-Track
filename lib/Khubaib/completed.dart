import 'package:courierapp/Khubaib/rating.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

class CompletedOrder extends StatefulWidget {
  const CompletedOrder({Key? key}) : super(key: key);

  @override
  _CompletedOrderState createState() => _CompletedOrderState();
}

class _CompletedOrderState extends State<CompletedOrder> with SingleTickerProviderStateMixin{
  AnimationController? _controller;
  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 10),vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: completedOrder(context),
    );
  }
}

Widget noCompletedOrder(context ,_controller) {
  return SizedBox(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 1),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          "assets/noData.json",
          controller: _controller,
          width: CustomSizes().dynamicWidth(context, 0.4),
        ),
        CustomSizes().heightBox(context, 0.03),
        text(context, "Oooops !", 0.06, CustomColors.customLightBlack,
            bold: true),
        CustomSizes().heightBox(context, 0.04),
        text(context, "No Data Found!", 0.04, CustomColors.customGrey,
            bold: true),
      ],
    ),
  );
}

Widget completedOrder(context) {
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
        return completedOrderCard(context);
      },
    ),
  );
}

Widget completedOrderCard(context) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 0.19),
    padding: EdgeInsets.symmetric(
      horizontal: CustomSizes().dynamicWidth(context, 0.05),
      vertical: CustomSizes().dynamicHeight(context, 0.01),
    ),
    margin: EdgeInsets.symmetric(
      vertical: CustomSizes().dynamicHeight(context, 0.0015),
    ),
    color: CustomColors.customWhite,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text(context, "Completed 14 Decemeber 3:14PM", 0.035,
                CustomColors.customGrey,
                bold: true),
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
        text(context, "\$370", 0.04, CustomColors.customBlack, bold: true),
        text(
            context,
            "Includes best practices that pros apply, as well as going over common mistakes that many Node.js developers make.",
            0.03,
            CustomColors.customLightBlack,
            bold: true),
        RatingBar.builder(
          glow: false,
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: CustomSizes().dynamicWidth(context, 0.05),
          unratedColor: CustomColors.customGrey,
          itemBuilder: (context, _) => const Icon(
            Icons.star_rounded,
            color: CustomColors.customYellow,
          ),
          onRatingUpdate: (rating) {},
        ),
        InkWell(
          onTap :()=>CustomRoutes().push(context,const RatingScreen()),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05),
                vertical: CustomSizes().dynamicHeight(context, 0)),
            decoration: BoxDecoration(
              color: CustomColors.customYellow,
              borderRadius: BorderRadius.circular(
                CustomSizes().dynamicWidth(context, 0.05),
              ),
            ),
            child: text(context, "RATE", 0.035, CustomColors.customBlack,bold:true),
          ),
        )
      ],
    ),
  );
}
