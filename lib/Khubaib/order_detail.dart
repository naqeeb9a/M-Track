import 'dart:math';

import 'package:camera/camera.dart';
import 'package:courierapp/Khubaib/rating.dart';
import 'package:courierapp/Khubaib/submit_order.dart';
import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Widgets/launch_camera.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  final RoundedLoadingButtonController _buttonController1 =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          text1: "Order " + widget.snapshot[widget.index]["id"].toString(),
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customYellow,
          directionVisibility:
              widget.snapshot[widget.index]["status"] == "delivered"
                  ? false
                  : true,
          latitude: widget.snapshot[widget.index]["status"] == "assigned"
              ? double.parse(
                  widget.snapshot[widget.index]["pick_up_lat"].toString())
              : double.parse(
                  widget.snapshot[widget.index]["customer_lat"].toString()),
          longitude: widget.snapshot[widget.index]["status"] == "assigned"
              ? double.parse(
                  widget.snapshot[widget.index]["pick_up_lng"].toString())
              : double.parse(
                  widget.snapshot[widget.index]["customer_lng"].toString())),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: widget.snapshot[widget.index]["status"] == "delivered"
                  ? false
                  : widget.snapshot[widget.index]["status"] == "assigned"
                      ? false
                      : true,
              child: RoundedLoadingButton(
                color: CustomColors.customYellow,
                controller: _buttonController1,
                onPressed: () async {
                  double calculateDistance(lat1, lon1, lat2, lon2) {
                    var p = 0.017453292519943295;
                    var c = cos;
                    var a = 0.5 -
                        c((lat2 - lat1) * p) / 2 +
                        c(lat1 * p) *
                            c(lat2 * p) *
                            (1 - c((lon2 - lon1) * p)) /
                            2;
                    return 12742 * asin(sqrt(a));
                  }

                  Future<Position> _determinePosition() async {
                    bool serviceEnabled;
                    LocationPermission permission;

                    // Test if location services are enabled.
                    serviceEnabled =
                        await Geolocator.isLocationServiceEnabled();
                    if (!serviceEnabled) {
                      // Location services are not enabled don't continue
                      // accessing the position and request users of the
                      // App to enable the location services.
                      return Future.error('Location services are disabled.');
                    }

                    permission = await Geolocator.checkPermission();
                    if (permission == LocationPermission.denied) {
                      permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.denied) {
                        // Permissions are denied, next time you could try
                        // requesting permissions again (this is also where
                        // Android's shouldShowRequestPermissionRationale
                        // returned true. According to Android guidelines
                        // your App should show an explanatory UI now.
                        return Future.error('Location permissions are denied');
                      }
                    }

                    if (permission == LocationPermission.deniedForever) {
                      // Permissions are denied forever, handle appropriately.
                      return Future.error(
                          'Location permissions are permanently denied, we cannot request permissions.');
                    }

                    // When we reach here, permissions are granted and we can
                    // continue accessing the position of the device.
                    return await Geolocator.getCurrentPosition();
                  }

                  Position position = await _determinePosition();
                  if (calculateDistance(
                        position.latitude,
                        position.longitude,
                        widget.snapshot[widget.index]["status"] == "assigned"
                            ? widget.snapshot[widget.index]["pick_up_lat"]
                            : widget.snapshot[widget.index]["customer_lat"],
                        widget.snapshot[widget.index]["status"] == "assigned"
                            ? widget.snapshot[widget.index]["pick_up_lng"]
                            : widget.snapshot[widget.index]["customer_lng"],
                      ) <=
                      0.5) {
                    final cameras = await availableCameras();
                    final firstCamera = cameras.first;
                    CustomRoutes().push(
                        context,
                        TakePictureScreen(
                            camera: firstCamera,
                            snapshot: widget.snapshot,
                            index: widget.index,
                            refreshState: widget.stateChange));
                    _buttonController1.reset();
                  } else {
                    _buttonController1.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "You are not near enough to the location",
                            0.04,
                            CustomColors.customWhite)));
                  }
                },
                child: text(
                    context, "Undelivered", 0.04, CustomColors.customBlack),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: widget.snapshot[widget.index]["status"] == "delivered"
                  ? false
                  : true,
              child: RoundedLoadingButton(
                color: CustomColors.customYellow,
                child: text(
                    context,
                    widget.snapshot[widget.index]["status"] == "assigned"
                        ? "Picked"
                        : "Delivered",
                    0.04,
                    CustomColors.customBlack),
                onPressed: () async {
                  double calculateDistance(lat1, lon1, lat2, lon2) {
                    var p = 0.017453292519943295;
                    var c = cos;
                    var a = 0.5 -
                        c((lat2 - lat1) * p) / 2 +
                        c(lat1 * p) *
                            c(lat2 * p) *
                            (1 - c((lon2 - lon1) * p)) /
                            2;
                    return 12742 * asin(sqrt(a));
                  }

                  Future<Position> _determinePosition() async {
                    bool serviceEnabled;
                    LocationPermission permission;

                    // Test if location services are enabled.
                    serviceEnabled =
                        await Geolocator.isLocationServiceEnabled();
                    if (!serviceEnabled) {
                      // Location services are not enabled don't continue
                      // accessing the position and request users of the
                      // App to enable the location services.
                      return Future.error('Location services are disabled.');
                    }

                    permission = await Geolocator.checkPermission();
                    if (permission == LocationPermission.denied) {
                      permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.denied) {
                        // Permissions are denied, next time you could try
                        // requesting permissions again (this is also where
                        // Android's shouldShowRequestPermissionRationale
                        // returned true. According to Android guidelines
                        // your App should show an explanatory UI now.
                        return Future.error('Location permissions are denied');
                      }
                    }

                    if (permission == LocationPermission.deniedForever) {
                      // Permissions are denied forever, handle appropriately.
                      return Future.error(
                          'Location permissions are permanently denied, we cannot request permissions.');
                    }

                    // When we reach here, permissions are granted and we can
                    // continue accessing the position of the device.
                    return await Geolocator.getCurrentPosition();
                  }

                  Position position = await _determinePosition();
                  if (calculateDistance(
                        position.latitude,
                        position.longitude,
                        widget.snapshot[widget.index]["status"] == "assigned"
                            ? widget.snapshot[widget.index]["pick_up_lat"]
                            : widget.snapshot[widget.index]["customer_lat"],
                        widget.snapshot[widget.index]["status"] == "assigned"
                            ? widget.snapshot[widget.index]["pick_up_lng"]
                            : widget.snapshot[widget.index]["customer_lng"],
                      ) <=
                      0.5) {
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
                              "Check your internt or tey again",
                              0.04,
                              CustomColors.customWhite)));
                    } else {
                      _buttonController.reset();

                      Navigator.pop(context, widget.stateChange());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: text(context, "Success", 0.04,
                              CustomColors.customWhite)));
                    }
                  } else {
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "You are not near enough to the location",
                            0.04,
                            CustomColors.customWhite)));
                  }
                },
                controller: _buttonController,
              ),
            ),
          ],
        ),
      ),
      body: Column(
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
              context, "Created", widget.snapshot[widget.index]["created_at"]),
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
              "A",
              widget.snapshot[widget.index]["pick_up_location"].toString(),
              widget.snapshot[widget.index]["pick_up_center_phone_number"]
                  .toString(),
              icon: true),
          orderCard(
              context,
              "B",
              widget.snapshot[widget.index]["consigneeAddress"],
              widget.snapshot[widget.index]["consigneeMobNo"],
              icon: true),
        ],
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
