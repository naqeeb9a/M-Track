import 'package:courierapp/Screens/live_location.dart';
import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/location_services.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: CustomColors.customYellow.withOpacity(0.2),
      appBar: customAppbar(
        context: context,
        text1: "Order ID #" + widget.snapshot[widget.index]["id"].toString(),
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
                if (widget.snapshot[widget.index]["status"] == "assigned") {
                  Position position =
                      await LocationFunctionality().determinePosition();
                  if (LocationFunctionality().calculateDistance(
                        position.latitude,
                        position.longitude,
                        widget.snapshot[widget.index]["status"] == "assigned"
                            ? widget.snapshot[widget.index]["pick_up_lat"]
                            : widget.snapshot[widget.index]["customer_lat"],
                        widget.snapshot[widget.index]["status"] == "assigned"
                            ? widget.snapshot[widget.index]["pick_up_lng"]
                            : widget.snapshot[widget.index]["customer_lng"],
                      ) >=
                      0.5) {
                    if (widget.snapshot[widget.index]["status"] == "assigned") {
                      var res = await RiderFunctionality().setOrderStatus(
                          "update-order",
                          widget.snapshot[widget.index]["tracking_number"],
                          widget.snapshot[widget.index]["status"] == "assigned"
                              ? "processing"
                              : "delivered-pending");
                      if (res == false) {
                        _buttonController.reset();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: text(
                                context,
                                "Check your internt or try again",
                                0.04,
                                CustomColors.customWhite)));
                      } else {
                        _buttonController.reset();
                        Navigator.popUntil(context, (route) => route.isFirst);
                        widget.stateChange();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: text(context, "Success", 0.04,
                                CustomColors.customWhite)));
                      }
                    }
                    _buttonController.reset();
                  } else {
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "You are not near enough to the location",
                            0.04,
                            CustomColors.customWhite)));
                  }
                } else {
                  CustomRoutes().push(
                      context,
                      LiveLocation(
                        lat: widget.snapshot[widget.index]["status"] ==
                                "assigned"
                            ? widget.snapshot[widget.index]["pick_up_lat"]
                                .toString()
                            : widget.snapshot[widget.index]["customer_lat"]
                                .toString(),
                        long: widget.snapshot[widget.index]["status"] ==
                                "assigned"
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
                }
              },
              controller: _buttonController,
            ),
          ),
        ),
      ),

      //Body started
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: CustomColors.customWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(1, 1),
                    color: CustomColors.customBlack.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 5),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSizes().heightBox(context, 0.05),
              text(context, "Order Details", 0.035,
                  CustomColors.customLightBlack,
                  bold: true),
              CustomSizes().heightBox(context, 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(
                      context,
                      "CN :-  " +
                          widget.snapshot[widget.index]["tracking_number"]
                              .toString(),
                      0.04,
                      CustomColors.customBlack,
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
                    child: text(
                        context,
                        "Order ID #" +
                            widget.snapshot[widget.index]["id"].toString(),
                        0.04,
                        CustomColors.customBlack),
                  )
                ],
              ),
              CustomSizes().heightBox(context, 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(
                      context,
                      "Date : " +
                          widget.snapshot[widget.index]["created_at"]
                              .toString()
                              .substring(0, 10),
                      0.042,
                      CustomColors.customBlack),
                  text(
                      context,
                      widget.snapshot[widget.index]["payment_method"] ?? "N/A",
                      0.042,
                      CustomColors.customBlack),
                ],
              ),
              CustomSizes().heightBox(context, 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(context, "Payment Method : ", 0.042,
                      CustomColors.customBlack),
                  Row(
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: widget.snapshot[widget.index]
                                    ["payment_method"] ==
                                null
                            ? CustomColors.customGrey
                            : widget.snapshot[widget.index]["payment_method"]
                                        .toString()
                                        .toLowerCase() ==
                                    "cash"
                                ? CustomColors.customGrey
                                : CustomColors.customGreen,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.attach_money,
                        color: widget.snapshot[widget.index]
                                    ["payment_method"] ==
                                null
                            ? CustomColors.customGrey
                            : widget.snapshot[widget.index]["payment_method"]
                                        .toString()
                                        .toLowerCase() ==
                                    "cash"
                                ? CustomColors.customBlack
                                : CustomColors.customGrey,
                      ),
                    ],
                  ),
                ],
              ),
              CustomSizes().heightBox(context, 0.05),
              Visibility(
                visible: widget.snapshot[widget.index]["status"] ==
                            "processing" ||
                        widget.snapshot[widget.index]["status"] == "assigned"
                    ? true
                    : false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(context, "Contact no : ", 0.042,
                        CustomColors.customBlack),
                    InkWell(
                      onTap: () async {
                        await launch(
                            "tel:${widget.snapshot[widget.index]["consigneeMobNo"]}");
                      },
                      child: const Icon(
                        Icons.phone,
                        color: CustomColors.customGreen,
                      ),
                    )
                  ],
                ),
              ),
              CustomSizes().heightBox(context, 0.05),
              text(
                  context,
                  "Customer : " +
                      widget.snapshot[widget.index]["consigneeName"]
                          .toString()
                          .toUpperCase(),
                  0.042,
                  CustomColors.customBlack,
                  bold: true),
              CustomSizes().heightBox(context, 0.05),
              const Divider(
                color: CustomColors.customBlack,
              ),
              Column(
                children: [
                  text(context, "Pickup Location :", 0.042,
                      CustomColors.customBlack),
                  CustomSizes().heightBox(context, 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: CustomColors.customYellow,
                        size: CustomSizes().dynamicHeight(context, 0.015),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  CustomSizes().dynamicWidth(context, 0.05)),
                          child: text(
                              context,
                              widget.snapshot[widget.index]["pick_up_location"]
                                  .toString(),
                              0.042,
                              CustomColors.customLightBlack,
                              bold: true),
                        ),
                      ),
                      Visibility(
                        visible: widget.snapshot[widget.index]["status"] ==
                                    "processing" ||
                                widget.snapshot[widget.index]["status"] ==
                                    "assigned"
                            ? true
                            : false,
                        child: InkWell(
                          onTap: () {
                            MapsLauncher.launchCoordinates(
                                widget.snapshot[widget.index]["pick_up_lat"],
                                widget.snapshot[widget.index]["pick_up_lng"]);
                          },
                          child: Icon(
                            Icons.directions,
                            color: CustomColors.customYellow,
                            size: CustomSizes().dynamicHeight(context, 0.03),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomSizes().heightBox(context, 0.05),
                  text(context, "Delivery Address :", 0.042,
                      CustomColors.customBlack),
                  CustomSizes().heightBox(context, 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: CustomColors.customYellow,
                        size: CustomSizes().dynamicHeight(context, 0.015),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  CustomSizes().dynamicWidth(context, 0.05)),
                          child: text(
                              context,
                              widget.snapshot[widget.index]["consigneeAddress"]
                                  .toString(),
                              0.042,
                              CustomColors.customLightBlack,
                              bold: true),
                        ),
                      ),
                      Visibility(
                        visible: widget.snapshot[widget.index]["status"] ==
                                    "processing" ||
                                widget.snapshot[widget.index]["status"] ==
                                    "assigned"
                            ? true
                            : false,
                        child: InkWell(
                          onTap: () {
                            MapsLauncher.launchCoordinates(
                                widget.snapshot[widget.index]["customer_lat"],
                                widget.snapshot[widget.index]["customer_lng"]);
                          },
                          child: Icon(
                            Icons.directions,
                            color: CustomColors.customYellow,
                            size: CustomSizes().dynamicHeight(context, 0.03),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: CustomColors.customBlack,
              ),
              CustomSizes().heightBox(context, 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(context, "Status :", 0.04, CustomColors.customLightBlack,
                      bold: true),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        color: widget.snapshot[widget.index]["status"] ==
                                    "assigned" ||
                                widget.snapshot[widget.index]["status"] ==
                                    "returned-pending"
                            ? Colors.red
                            : CustomColors.customGreen,
                        borderRadius: BorderRadius.circular(5)),
                    child: text(
                        context,
                        widget.snapshot[widget.index]["status"] == "assigned"
                            ? "New Courier to pick"
                            : widget.snapshot[widget.index]["status"] ==
                                    "processing"
                                ? "Delivering Courier"
                                : widget.snapshot[widget.index]["status"] ==
                                        "returned-pending"
                                    ? "Waiting for parcel return"
                                    : widget.snapshot[widget.index]["status"] ==
                                            "delivered"
                                        ? "Delivered"
                                        : "Waiting for approval",
                        0.035,
                        widget.snapshot[widget.index]["status"] == "assigned" ||
                                widget.snapshot[widget.index]["status"] ==
                                    "returned-pending"
                            ? CustomColors.customWhite
                            : CustomColors.customLightBlack,
                        bold: true),
                  ),
                ],
              ),
            ],
          ),
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
