import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.customYellow.withOpacity(0.2),
        appBar: customAppbar(
            context: context,
            text1: "QR Screen",
            automaticallyImplyLeading: true,
            backgroundColor: CustomColors.customYellow),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    color: CustomColors.customGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.white,
                      icon: ValueListenableBuilder(
                        valueListenable: cameraController.torchState,
                        builder: (context, state, child) {
                          switch (state as TorchState) {
                            case TorchState.off:
                              return const Icon(Icons.flash_off,
                                  color: Colors.grey);
                            case TorchState.on:
                              return const Icon(Icons.flash_on,
                                  color: Colors.yellow);
                          }
                        },
                      ),
                      iconSize: 32.0,
                      onPressed: () => cameraController.toggleTorch(),
                    ),
                    IconButton(
                      color: Colors.grey,
                      icon: ValueListenableBuilder(
                        valueListenable: cameraController.cameraFacingState,
                        builder: (context, state, child) {
                          switch (state as CameraFacing) {
                            case CameraFacing.front:
                              return const Icon(Icons.camera_front);
                            case CameraFacing.back:
                              return const Icon(Icons.camera_rear);
                          }
                        },
                      ),
                      iconSize: 32.0,
                      onPressed: () => cameraController.switchCamera(),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: CustomSizes().dynamicHeight(context, 0.4),
                  width: CustomSizes().dynamicWidth(context, 0.7),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4, color: CustomColors.customYellow)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MobileScanner(
                        allowDuplicates: false,
                        controller: cameraController,
                        onDetect: (barcode, args) {
                          final String? code = barcode.rawValue;
                          debugPrint('Barcode found! $code');
                        }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: text(context, "Scan the QR to pick Orders in Bulk", 0.04,
                    CustomColors.customBlack),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
