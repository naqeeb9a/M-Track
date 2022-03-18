import 'package:courierapp/Khubaib/rating.dart';
import 'package:courierapp/Khubaib/submit_order.dart';
import 'package:courierapp/Screens/live_location.dart';
import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OrderDetail extends StatefulWidget {
  final List snapshot;
  final int index;
  final Function stateChange;
  const OrderDetail(
      {Key? key,
      required this.snapshot,
      required this.index,
      required this.stateChange})
      : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        context: context,
        text1: "Order " + widget.snapshot[widget.index]["custRefNo"].toString(),
        automaticallyImplyLeading: true,
        backgroundColor: CustomColors.customYellow,
      ),

      //bottom navigation bar
      bottomNavigationBar: Visibility(
        visible: widget.snapshot[widget.index]["status"] ==
                    "returned-pending" ||
                widget.snapshot[widget.index]["status"] == "delivered-pending"
            ? false
            : true,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Visibility(
            visible: widget.snapshot[widget.index]["status"] == "delivered"
                ? false
                : true,
            child: RoundedLoadingButton(
              color: CustomColors.customYellow,
              child: text(
                  context,
                  widget.snapshot[widget.index]["status"] == "assigned"
                      ? "Picked"
                      : "Start delivering",
                  0.04,
                  CustomColors.customBlack),
              onPressed: () async {
                CustomRoutes().push(
                    context,
                    LiveLocation(
                      lat: widget.snapshot[widget.index]["status"] == "assigned"
                          ? widget.snapshot[widget.index]["pick_up_lat"]
                              .toString()
                          : widget.snapshot[widget.index]["customer_lat"]
                              .toString(),
                      long:
                          widget.snapshot[widget.index]["status"] == "assigned"
                              ? widget.snapshot[widget.index]["pick_up_lng"]
                                  .toString()
                              : widget.snapshot[widget.index]["customer_lng"]
                                  .toString(),
                      orderId: widget.snapshot[widget.index]["id"].toString(),
                      index: widget.index,
                      snapshot: widget.snapshot,
                      stateChange: widget.stateChange,
                    ));
                _buttonController.reset();
              },
              controller: _buttonController,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizes().heightBox(context, 0.05),
            personCard(context,
                phoneIcon: true,
                containerColor: false,
                name: widget.snapshot[widget.index]["consigneeName"],
                phone: widget.snapshot[widget.index]["consigneeMobNo"]),
            CustomSizes().heightBox(context, 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, .05),
              ),
              child: text(context, "Info", 0.035, CustomColors.customGrey,
                  bold: true),
            ),
            CustomSizes().heightBox(context, 0.025),
            orderBox(
                context,
                "Created",
                widget.snapshot[widget.index]["created_at"]
                    .toString()
                    .substring(0, 10)),
            CustomSizes().heightBox(context, 0.025),
            orderBox(context, "Weight",
                "Up to " + widget.snapshot[widget.index]["weight"] + "kg"),
            CustomSizes().heightBox(context, 0.025),
            orderBox(
                context,
                "Payment Method",
                widget.snapshot[widget.index]["payment_method"] ??
                    "Not Provided"),
            CustomSizes().heightBox(context, 0.025),
            orderCard(
                context,
                "P",
                widget.snapshot[widget.index]["pick_up_location"].toString(),
                widget.snapshot[widget.index]["pick_up_center_phone_number"]
                    .toString(),
                icon: true),
            orderCard(
                context,
                "D",
                widget.snapshot[widget.index]["consigneeAddress"],
                widget.snapshot[widget.index]["consigneeMobNo"],
                icon: true),
          ],
        ),
      ),
    );
  }
}

Widget orderBox(context, title, title1) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 0.06),
    padding: EdgeInsets.symmetric(
      horizontal: CustomSizes().dynamicWidth(context, .05),
    ),
    color: CustomColors.customWhite,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(context, title, 0.035, CustomColors.customGrey, bold: true),
        text(context, title1, 0.035, CustomColors.customLightBlack, bold: true),
      ],
    ),
  );
}
