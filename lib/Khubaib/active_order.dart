import 'package:badges/badges.dart';
import 'package:courierapp/Khubaib/order_detail.dart';
import 'package:courierapp/Khubaib/qr_screen.dart';
import 'package:courierapp/Widgets/buttons.dart';
import 'package:courierapp/Widgets/loader.dart';
import 'package:courierapp/Widgets/search_widget.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActiveOrder extends StatefulWidget {
  const ActiveOrder({Key? key}) : super(key: key);

  @override
  _ActiveOrderState createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.customYellow.withOpacity(0.2),
        body: const ActiveOrderFunctionality());
  }
}

// Widget noActiverOrder(context) {
//   return Container(
//     width: CustomSizes().dynamicWidth(context, 1),
//     height: CustomSizes().dynamicHeight(context, 1),
//     color: CustomColors.customGrey.withOpacity(0.2),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         noactiveOrderCard(
//             context,
//             "https://www.pngkit.com/png/full/72-724560_png-file-tracking-parcel-png.png",
//             "Send Package",
//             "Deliver or recieve items such as gifts ,documents,keys",
//             CustomColors.customYellow),
//         CustomSizes().heightBox(context, 0.065),
//         noactiveOrderCard(
//             context,
//             "https://cdn0.iconfinder.com/data/icons/line-design-word-processing-set-3-1/21/mailing-recipient-list-512.png",
//             "I am Recipent",
//             "Track an incoming delivery in the app",
//             CustomColors.customBlack)
//       ],
//     ),
//   );
// }

// Widget noactiveOrderCard(context, image, title, subtitle, pngColor) {
//   return Container(
//     width: CustomSizes().dynamicWidth(context, 0.85),
//     height: CustomSizes().dynamicHeight(context, .15),
//     decoration: BoxDecoration(
//       color: CustomColors.customWhite,
//       borderRadius: BorderRadius.circular(
//         CustomSizes().dynamicWidth(context, 0.05),
//       ),
//     ),
//     child: Row(
//       children: [
//         SizedBox(
//           width: CustomSizes().dynamicWidth(context, 0.3),
//           height: CustomSizes().dynamicHeight(context, .1),
//           child: Image.network(
//             image,
//             color: pngColor,
//           ),
//         ),
//         Flexible(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               text(context, title, 0.045, CustomColors.customBlack, bold: true),
//               CustomSizes().heightBox(context, 0.02),
//               text(context, subtitle, 0.035, CustomColors.customGrey),
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }

class ActiveOrderFunctionality extends StatefulWidget {
  const ActiveOrderFunctionality({Key? key}) : super(key: key);

  @override
  State<ActiveOrderFunctionality> createState() =>
      _ActiveOrderFunctionalityState();
}

class _ActiveOrderFunctionalityState extends State<ActiveOrderFunctionality> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RiderFunctionality().getRiderInfo(query: "active-order"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return retry(context, () {
                setState(() {});
              });
            } else if (snapshot.data.length == 0) {
              return Center(
                child: text(context, "No Active Orders", 0.04,
                    CustomColors.customBlack),
              );
            } else {
              List pickedOrders = [];
              List newOrders = [];
              for (var item in snapshot.data) {
                if (item["status"] == "assigned") {
                  newOrders.add(item);
                } else {
                  pickedOrders.add(item);
                }
              }
              bool isSelected1 = false;
              bool isSelected2 = false;
              return StatefulBuilder(builder: (context, changeState) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Badge(
                              badgeContent: text(
                                  context,
                                  newOrders.length.toString(),
                                  0.04,
                                  CustomColors.customWhite),
                              animationType: BadgeAnimationType.scale,
                              child: ChoiceChip(
                                  selectedColor: CustomColors.customYellow,
                                  onSelected: (value) => changeState(() {
                                        isSelected1 = value;
                                      }),
                                  label: text(context, "Assigned Orders", 0.035,
                                      Colors.black),
                                  selected: isSelected1),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Badge(
                              badgeContent: text(
                                  context,
                                  pickedOrders.length.toString(),
                                  0.04,
                                  CustomColors.customWhite),
                              animationType: BadgeAnimationType.scale,
                              child: ChoiceChip(
                                  onSelected: (value) => changeState(() {
                                        isSelected2 = value;
                                      }),
                                  selectedColor: CustomColors.customYellow,
                                  label: text(context, "Picked Orders", 0.035,
                                      Colors.black),
                                  selected: isSelected2),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  CustomRoutes()
                                      .push(context, const QRScreen());
                                },
                                child: const Icon(Icons.qr_code)),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    text(
                        context,
                        "Total Orders : " + snapshot.data.length.toString(),
                        0.04,
                        CustomColors.customBlack),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDeligate(
                                  snapshot.data, isSelected1, isSelected2, () {
                                setState(() {});
                              }, newOrders, pickedOrders));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                CustomSizes().dynamicWidth(context, 0.05),
                            vertical:
                                CustomSizes().dynamicHeight(context, 0.01),
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: CustomColors.customWhite,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.search),
                              text(context, "Search CN", 0.03,
                                  CustomColors.customBlack),
                              const Icon(Icons.clear),
                            ],
                          ),
                        )),
                    Expanded(
                      child: ActiveOrderList(
                        isSelected1: isSelected1,
                        isSelected2: isSelected2,
                        newOrders: newOrders,
                        pickedOrders: pickedOrders,
                        snapshot: snapshot.data,
                        setState: () {
                          setState(() {});
                        },
                      ),
                    )
                  ],
                );
              });
            }
          } else {
            return const Loader();
          }
        });
  }
}

class ActiveOrderList extends StatelessWidget {
  final bool isSelected1, isSelected2;
  final VoidCallback setState;
  final List newOrders, pickedOrders;
  final dynamic snapshot;
  const ActiveOrderList(
      {Key? key,
      required this.isSelected1,
      required this.isSelected2,
      required this.setState,
      required this.newOrders,
      required this.pickedOrders,
      required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: CustomSizes().dynamicHeight(context, 0),
      ),
      itemCount: isSelected1 == true && isSelected2 == false
          ? newOrders.length
          : isSelected2 == true && isSelected1 == false
              ? pickedOrders.length
              : snapshot.length,
      itemBuilder: (BuildContext context, int index) {
        return ActiveOrderCard(
            context: context,
            snapshot: isSelected1 == true && isSelected2 == false
                ? newOrders
                : isSelected2 == true && isSelected1 == false
                    ? pickedOrders
                    : snapshot,
            index: index,
            setState: setState);
      },
    );
  }
}

class ActiveOrderCard extends StatelessWidget {
  final BuildContext context;
  final dynamic snapshot, index;
  final VoidCallback setState;
  const ActiveOrderCard(
      {Key? key,
      required this.context,
      required this.snapshot,
      required this.index,
      required this.setState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomRoutes().push(
            context,
            OrderDetail(
              snapshot: snapshot,
              index: index,
              stateChange: setState,
            ));
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, 0.05),
              vertical: CustomSizes().dynamicHeight(context, 0.01),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, 0.02),
              vertical: CustomSizes().dynamicHeight(context, 0.01),
            ),
            decoration: BoxDecoration(
                color: CustomColors.customWhite,
                boxShadow: [
                  BoxShadow(
                      color: CustomColors.customBlack.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(1, 1))
                ],
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                          context,
                          "CN :-  " +
                              snapshot[index]["tracking_number"].toString(),
                          0.04,
                          CustomColors.customWhite,
                          bold: true),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: CustomSizes().dynamicWidth(context, 0.01),
                        ),
                        decoration: BoxDecoration(
                          color: snapshot[index]["status"] == "assigned" ||
                                  snapshot[index]["status"] ==
                                      "returned-pending"
                              ? Colors.red
                              : CustomColors.customGreen,
                          borderRadius: BorderRadius.circular(
                            CustomSizes().dynamicWidth(context, 0.05),
                          ),
                        ),
                        child: text(
                            context,
                            "Order ID #" + snapshot[index]["id"].toString(),
                            0.04,
                            snapshot[index]["status"] == "assigned" ||
                                    snapshot[index]["status"] ==
                                        "returned-pending"
                                ? CustomColors.customWhite
                                : CustomColors.customLightBlack),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(
                        context,
                        snapshot[index]["consigneeName"]
                            .toString()
                            .toUpperCase(),
                        0.04,
                        CustomColors.customBlack,
                        bold: true),
                    Visibility(
                      visible: snapshot[index]["status"] == "processing" ||
                              snapshot[index]["status"] == "assigned"
                          ? true
                          : false,
                      child: InkWell(
                        onTap: () async {
                          await launch(
                              "tel:${snapshot[index]["consigneeMobNo"]}");
                        },
                        child: const Icon(
                          Icons.phone,
                          color: CustomColors.customGreen,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: CustomColors.customBlack,
                ),
                const SizedBox(
                  height: 5,
                ),
                text(context, "Pickup Location :", 0.04,
                    CustomColors.customBlack,
                    bold: true),
                text(
                  context,
                  snapshot[index]["pick_up_location"].toString(),
                  0.05,
                  CustomColors.customBlack,
                ),
                const SizedBox(
                  height: 5,
                ),
                text(context, "Delivery Address :", 0.04,
                    CustomColors.customBlack,
                    bold: true),
                const SizedBox(
                  height: 5,
                ),
                text(
                  context,
                  snapshot[index]["consigneeAddress"].toString(),
                  0.05,
                  CustomColors.customBlack,
                ),
                const Divider(
                  color: CustomColors.customBlack,
                ),
                text(
                    context,
                    "Amount : PKR. " +
                        double.parse(snapshot[index]["codAmount"].toString())
                            .toStringAsFixed(0),
                    0.04,
                    CustomColors.customBlack,
                    bold: true),
                CustomSizes().heightBox(context, 0.05),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05),
                vertical: CustomSizes().dynamicHeight(context, 0.01),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                  color: snapshot[index]["status"] == "assigned" ||
                          snapshot[index]["status"] == "returned-pending"
                      ? Colors.red
                      : CustomColors.customGreen,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: text(
                  context,
                  snapshot[index]["status"] == "assigned"
                      ? "New Courier to pick"
                      : snapshot[index]["status"] == "processing"
                          ? "Delivering Courier"
                          : snapshot[index]["status"] == "returned-pending"
                              ? "Waiting for parcel return"
                              : "Waiting for approval",
                  0.035,
                  snapshot[index]["status"] == "assigned" ||
                          snapshot[index]["status"] == "returned-pending"
                      ? CustomColors.customWhite
                      : CustomColors.customLightBlack,
                  bold: true),
            ),
          )
        ],
      ),
    );
  }
}
