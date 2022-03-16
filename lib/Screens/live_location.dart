import 'dart:async';

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

class LiveLocation extends StatefulWidget {
  final String lat, long, orderId;
  const LiveLocation(
      {Key? key, required this.lat, required this.long, required this.orderId})
      : super(key: key);

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  bool delivering = false;
  late final AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: CustomSizes().dynamicWidth(context, 0.05)),
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
              child: text(context, "Enable Live Tracking", 0.05,
                  CustomColors.customBlack,
                  bold: true, alignText: TextAlign.start),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: text(
                  context,
                  "Click on the button to enable live tracking for this order",
                  0.04,
                  CustomColors.customBlack,
                  alignText: TextAlign.start),
            ),
            LottieBuilder.asset(
              "assets/liveLocation.json",
              controller: _controller,
            ),
            RoundedLoadingButton(
                color: CustomColors.customYellow,
                controller: _buttonController,
                onPressed: () async {
                  if (delivering == false) {
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
                          return Future.error(
                              'Location permissions are denied');
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
                    _timer =
                        Timer.periodic(const Duration(seconds: 10), (t) async {
                      var res = RiderFunctionality().sendLiveLocation(
                          position.latitude,
                          position.longitude,
                          widget.orderId);
                      debugPrint("location sent " +
                          position.latitude.toString() +
                          " , " +
                          position.longitude.toString() +
                          " , order id = " +
                          widget.orderId.toString());
                      debugPrint(res);
                    });

                    setState(() {
                      _controller.repeat();
                      delivering = true;
                      _buttonController.reset();
                    });
                  } else {
                    _timer?.cancel();
                    setState(() {
                      _controller.reset();
                      delivering = false;
                      _buttonController.reset();
                    });
                  }
                },
                child: text(
                    context,
                    delivering == true ? "Stop" : "Start Sharing Location",
                    0.04,
                    CustomColors.customBlack)),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
