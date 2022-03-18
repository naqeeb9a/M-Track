import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Widgets/loader.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final List snapshot;
  final int index;
  final dynamic refreshState;
  final String reason;
  const TakePictureScreen(
      {Key? key,
      required this.camera,
      required this.snapshot,
      required this.index,
      required this.refreshState,
      required this.reason})
      : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customBlack,
      appBar: customAppbar(
          context: context,
          text1: "Take a picture",
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customYellow),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isloading == true
                    ? Column(
                        children: [
                          LottieBuilder.asset("assets/image.json"),
                          text(context, "Sending picture", 0.04,
                              CustomColors.customWhite)
                        ],
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        child: CameraPreview(_controller)),
                ClickPicture(
                  controller: _controller,
                  initializeControllerFuture: _initializeControllerFuture,
                  snapshot: widget.snapshot,
                  index: widget.index,
                  refreshState: widget.refreshState,
                  reason: widget.reason,
                ),
                text(context, "Photo", 0.04, CustomColors.customYellow),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Loader();
          }
        },
      ),
    );
  }
}

class ClickPicture extends StatefulWidget {
  final List snapshot;
  final int index;
  final CameraController controller;
  final dynamic refreshState;
  final String reason;
  final Future<void> initializeControllerFuture;
  const ClickPicture(
      {Key? key,
      required this.controller,
      required this.initializeControllerFuture,
      required this.snapshot,
      required this.index,
      required this.refreshState,
      required this.reason})
      : super(key: key);

  @override
  State<ClickPicture> createState() => _ClickPictureState();
}

class _ClickPictureState extends State<ClickPicture> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        // Take the Picture in a try / catch block. If anything goes wrong,
        // catch the error.

        try {
          // Ensure that the camera is initialized.
          await widget.initializeControllerFuture;

          // Attempt to take a picture and get the file `image`
          // where it was saved.
          final XFile image = await widget.controller.takePicture();
          widget.controller.pausePreview();
          final encodeImage = base64Encode(await image.readAsBytes());
          // if(widget.reason=="delivered")
          // {

          // }
          // else{
          var res = await RiderFunctionality().setOrderStatus(
              "update-order",
              widget.snapshot[widget.index]["tracking_number"],
              "returned-pending",
              img: encodeImage,
              reason: widget.reason);
          if (res == false) {
            widget.controller.resumePreview();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: text(context, "Check your internt or try again", 0.04,
                    CustomColors.customWhite)));
          } else {
            Navigator.popUntil(context, (route) => route.isFirst);
            widget.refreshState();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    text(context, "Success", 0.04, CustomColors.customWhite)));
          }
          // }
          // If the picture was taken, display it on a new screen.

          setState(() {
            isLoading = false;
          });
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          widget.controller.resumePreview();
          // If an error occurs, log the error to the console.
          debugPrint(e.toString());
        }
      },
      child: CircleAvatar(
        radius: CustomSizes().dynamicWidth(context, 0.1),
        child: (isLoading == true)
            ? const CircularProgressIndicator(
                color: CustomColors.customWhite,
              )
            : Icon(
                Icons.camera,
                size: CustomSizes().dynamicWidth(context, 0.07),
              ),
      ),
    );
  }
}
