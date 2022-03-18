import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:signature/signature.dart';

import '../backend/orders.dart';

class DigitalSignature extends StatefulWidget {
  final dynamic snapshot;
  final int index;
  final Function stateChange;
  const DigitalSignature(
      {Key? key,
      required this.snapshot,
      required this.index,
      required this.stateChange})
      : super(key: key);

  @override
  State<DigitalSignature> createState() => _DigitalSignatureState();
}

class _DigitalSignatureState extends State<DigitalSignature> {
  final RoundedLoadingButtonController _button =
      RoundedLoadingButtonController();
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: CustomColors.customBlack,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => debugPrint('onDrawStart called!'),
    onDrawEnd: () => debugPrint('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => debugPrint('Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          text1: "Digital Signature",
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customYellow),
      body: Column(
        children: <Widget>[
          //SIGNATURE CANVAS
          Expanded(
            child: Signature(
              controller: _controller,
              backgroundColor: CustomColors.customWhite,
            ),
          ),
          //OK AND CLEAR BUTTONS
          Container(
            decoration: const BoxDecoration(color: CustomColors.customGrey),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //SHOW EXPORTED IMAGE IN NEW ROUTE
                IconButton(
                  icon: const Icon(Icons.check),
                  color: Colors.black,
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      final Uint8List? data = await _controller.toPngBytes();

                      XFile file = XFile.fromData(data!);
                      final encodeImage =
                          base64Encode(await file.readAsBytes());

                      if (encodeImage.isNotEmpty) {
                        await Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return Scaffold(
                                appBar: customAppbar(
                                    context: context,
                                    text1: "Delivery",
                                    automaticallyImplyLeading: true,
                                    backgroundColor: CustomColors.customYellow),
                                body: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        color: Colors.grey[300],
                                        child: Image.memory(data),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RoundedLoadingButton(
                                          color: CustomColors.customYellow,
                                          controller: _button,
                                          onPressed: () async {
                                            var res = await RiderFunctionality()
                                                .deliverOrderStatus(
                                                    "update-order",
                                                    widget.snapshot[
                                                            widget.index]
                                                        ["tracking_number"],
                                                    widget.snapshot[widget
                                                                    .index]
                                                                ["status"] ==
                                                            "assigned"
                                                        ? "processing"
                                                        : "delivered-pending",
                                                    encodeImage,
                                                    "card");
                                            if (res == false) {
                                              _button.reset();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: text(
                                                          context,
                                                          "Check your internt or tey again",
                                                          0.04,
                                                          CustomColors
                                                              .customWhite)));
                                            } else {
                                              _button.reset();
                                              Navigator.popUntil(context,
                                                  (route) => route.isFirst);

                                              widget.stateChange();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: text(
                                                          context,
                                                          "Success",
                                                          0.04,
                                                          CustomColors
                                                              .customWhite)));
                                            }
                                          },
                                          child: text(context, "Card payment",
                                              0.04, CustomColors.customBlack)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      text(context, "Or", 0.04,
                                          CustomColors.customGrey),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RoundedLoadingButton(
                                          color: CustomColors.customYellow,
                                          controller: _button,
                                          onPressed: () async {
                                            var res = await RiderFunctionality()
                                                .deliverOrderStatus(
                                                    "update-order",
                                                    widget.snapshot[
                                                            widget.index]
                                                        ["tracking_number"],
                                                    widget.snapshot[widget
                                                                    .index]
                                                                ["status"] ==
                                                            "assigned"
                                                        ? "processing"
                                                        : "delivered-pending",
                                                    encodeImage,
                                                    "cash");
                                            if (res == false) {
                                              _button.reset();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: text(
                                                          context,
                                                          "Check your internt or tey again",
                                                          0.04,
                                                          CustomColors
                                                              .customWhite)));
                                            } else {
                                              _button.reset();
                                              Navigator.popUntil(context,
                                                  (route) => route.isFirst);
                                              widget.stateChange();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: text(
                                                          context,
                                                          "Success",
                                                          0.04,
                                                          CustomColors
                                                              .customWhite)));
                                            }
                                          },
                                          child: text(context, "Cash payment",
                                              0.04, CustomColors.customBlack))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.undo),
                  color: Colors.black,
                  onPressed: () {
                    setState(() => _controller.undo());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.redo),
                  color: Colors.black,
                  onPressed: () {
                    setState(() => _controller.redo());
                  },
                ),
                //CLEAR CANVAS
                IconButton(
                  icon: const Icon(Icons.clear),
                  color: Colors.black,
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
