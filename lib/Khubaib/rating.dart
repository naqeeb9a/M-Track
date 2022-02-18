
import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Widgets/colorful_button.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "Rating"),
          CustomSizes().heightBox(context, 0.05),
          SizedBox(
            width: CustomSizes().dynamicWidth(context, 1),
            height: CustomSizes().dynamicHeight(context, 0.1),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.05)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      CustomSizes().dynamicWidth(context, 0.025),
                    ),
                    child: Container(
                      width: CustomSizes().dynamicWidth(context, 0.2),
                      height: CustomSizes().dynamicHeight(context, 0.1),
                      decoration: const BoxDecoration(
                        color: CustomColors.customSkimColor,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: CustomSizes().dynamicWidth(context, 0.03),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        text(context, "John Smith", 0.04,
                            CustomColors.customBlack,
                            bold: true),
                        CustomSizes().heightBox(context, 0.02),
                        text(context, "+93214567895", 0.04,
                            CustomColors.customBlack,
                            bold: true)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomSizes().heightBox(context, 0.015),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, 0.05),
            ),
            child: Column(
              children: [
                Divider(
                  thickness: CustomSizes().dynamicHeight(context, 0.001),
                ),
                CustomSizes().heightBox(context, 0.02),
                Row(
                  children: [
                    text(context, "Rate Delivery Boy", 0.04,
                        CustomColors.customGrey,
                        bold: true),
                  ],
                ),
                CustomSizes().heightBox(context, 0.015),
                RatingBar.builder(
                  glow: false,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  unratedColor: CustomColors.customGrey,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: CustomColors.customYellow,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          ),
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
