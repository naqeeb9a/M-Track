import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:courierapp/Khubaib/digital_signature.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Widgets/buttons.dart';
import '../Widgets/input_buttons.dart';
import '../Widgets/launch_camera.dart';

class LiveLocation extends StatefulWidget {
  final String lat, long, orderId;
  final dynamic snapshot, stateChange;
  final int index;
  const LiveLocation(
      {Key? key,
      required this.lat,
      required this.long,
      required this.orderId,
      required this.snapshot,
      required this.stateChange,
      required this.index})
      : super(key: key);

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _buttonController1 =
      RoundedLoadingButtonController();

  final TextEditingController _editingController = TextEditingController();
  bool delivering = false;
  late final AnimationController _controller;

  startSharingLiveLocation() async {
    Position position = await _determinePosition();
    _timer = Timer.periodic(const Duration(seconds: 10), (t) async {
      RiderFunctionality().sendLiveLocation(
          position.latitude, position.longitude, widget.orderId);
      debugPrint("location sent " +
          position.latitude.toString() +
          " , " +
          position.longitude.toString() +
          " , order id = " +
          widget.orderId.toString());
    });
  }

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..repeat();
    startSharingLiveLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, 0.05)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                      onTap: () {
                        CustomRoutes().pop(context);
                      },
                      child: const Icon(Icons.arrow_back)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: text(context, "Enabled Live Tracking", 0.05,
                      CustomColors.customBlack,
                      bold: true, alignText: TextAlign.start),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: text(
                      context,
                      "Your location is being tracked don't close the app",
                      0.04,
                      CustomColors.customBlack,
                      alignText: TextAlign.start),
                ),
                LottieBuilder.asset(
                  "assets/liveLocation.json",
                  controller: _controller,
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    MapsLauncher.launchCoordinates(
                        double.parse(widget.lat), double.parse(widget.long));
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.directions,
                        size: CustomSizes().dynamicWidth(context, 0.1),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      text(context, "Get directions", 0.04,
                          CustomColors.customBlack),
                      const SizedBox(
                        height: 10,
                      ),
                      actionButton(
                          text1: "Delivered",
                          controller: _buttonController,
                          function: () async {
                            Position position = await _determinePosition();
                            if (calculateDistance(
                                  position.latitude,
                                  position.longitude,
                                  widget.snapshot[widget.index]["status"] ==
                                          "assigned"
                                      ? widget.snapshot[widget.index]
                                          ["pick_up_lat"]
                                      : widget.snapshot[widget.index]
                                          ["customer_lat"],
                                  widget.snapshot[widget.index]["status"] ==
                                          "assigned"
                                      ? widget.snapshot[widget.index]
                                          ["pick_up_lng"]
                                      : widget.snapshot[widget.index]
                                          ["customer_lng"],
                                ) >=
                                0.5) {
                              if (widget.snapshot[widget.index]["status"] ==
                                  "assigned") {
                                var res = await RiderFunctionality()
                                    .setOrderStatus(
                                        "update-order",
                                        widget.snapshot[widget.index]
                                            ["tracking_number"],
                                        widget.snapshot[widget.index]
                                                    ["status"] ==
                                                "assigned"
                                            ? "processing"
                                            : "delivered-pending");
                                if (res == false) {
                                  _buttonController.reset();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: text(
                                              context,
                                              "Check your internt or tey again",
                                              0.04,
                                              CustomColors.customWhite)));
                                } else {
                                  _buttonController.reset();
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  widget.stateChange();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: text(context, "Success",
                                              0.04, CustomColors.customWhite)));
                                }
                              } else {
                                CustomRoutes().push(
                                    context,
                                    DigitalSignature(
                                      snapshot: widget.snapshot,
                                      index: widget.index,
                                      stateChange: widget.stateChange,
                                    ));
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
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      actionButton(
                          text1: "Undelivered",
                          controller: _buttonController1,
                          function: () async {
                            Position position = await _determinePosition();
                            if (calculateDistance(
                                  position.latitude,
                                  position.longitude,
                                  widget.snapshot[widget.index]["status"] ==
                                          "assigned"
                                      ? widget.snapshot[widget.index]
                                          ["pick_up_lat"]
                                      : widget.snapshot[widget.index]
                                          ["customer_lat"],
                                  widget.snapshot[widget.index]["status"] ==
                                          "assigned"
                                      ? widget.snapshot[widget.index]
                                          ["pick_up_lng"]
                                      : widget.snapshot[widget.index]
                                          ["customer_lng"],
                                ) >=
                                0.5) {
                              getReason();
                            } else {
                              _buttonController1.reset();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: text(
                                      context,
                                      "You are not near enough to the location",
                                      0.04,
                                      CustomColors.customWhite),
                                ),
                              );
                            }
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  RoundedLoadingButton actionButton(
      {required String text1,
      required RoundedLoadingButtonController controller,
      required VoidCallback function}) {
    return RoundedLoadingButton(
        controller: controller,
        onPressed: function,
        color: CustomColors.customYellow,
        child: text(context, text1, 0.04, CustomColors.customWhite));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getReason() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(context, "Reason", 0.04, CustomColors.customBlack),
                InkWell(
                    onTap: () {
                      _buttonController1.reset();
                      CustomRoutes().pop(context);
                    },
                    child: const Icon(Icons.close))
              ],
            ),
            content: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RegisterInputField(
                    context: context,
                    text1: "Why undelivered",
                    hintText: "Tell us the reason why",
                    controller: _editingController,
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  coloredButton(context, "Submit", CustomColors.customYellow,
                      function: () async {
                    if (_editingController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: text(context, "Field can't be empty", 0.04,
                              CustomColors.customWhite)));
                    } else {
                      CustomRoutes().pop(context);
                      final cameras = await availableCameras();

                      if (cameras.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: text(context, "No cameras available", 0.04,
                                CustomColors.customWhite)));
                        _buttonController1.reset();
                      } else {
                        final firstCamera = cameras.first;
                        CustomRoutes().push(
                            context,
                            TakePictureScreen(
                              camera: firstCamera,
                              snapshot: widget.snapshot,
                              index: widget.index,
                              refreshState: widget.stateChange,
                              reason: _editingController.text,
                            ));
                        _buttonController1.reset();
                      }
                    }
                  })
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _editingController.dispose();
    super.dispose();
  }
}
