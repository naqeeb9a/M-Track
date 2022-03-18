import 'package:courierapp/Khubaib/order_detail.dart';
import 'package:courierapp/Widgets/buttons.dart';
import 'package:courierapp/Widgets/loader.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activeOrder(context, () {
        setState(() {});
      }),
    );
  }
}

Widget activeOrder(context, setState) {
  return SizedBox(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 1),
    child: FutureBuilder(
        future: RiderFunctionality().getRiderInfo(query: "pending-status"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return retry(context, setState);
            } else if (snapshot.data.length == 0) {
              return Center(
                child: text(context, "No pending Orders", 0.04,
                    CustomColors.customBlack),
              );
            } else {
              List pickedOrders = [];
              List newOrders = [];
              for (var item in snapshot.data) {
                if (item["status"] == "delivered-pending") {
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        ChoiceChip(
                            selectedColor: CustomColors.customYellow,
                            onSelected: (value) => changeState(() {
                                  isSelected1 = value;
                                }),
                            label: text(context, "Delivered Pending", 0.03,
                                Colors.black),
                            selected: isSelected1),
                        const SizedBox(
                          width: 20,
                        ),
                        ChoiceChip(
                            onSelected: (value) => changeState(() {
                                  isSelected2 = value;
                                }),
                            selectedColor: CustomColors.customYellow,
                            label: text(context, "Returned Pending", 0.03,
                                Colors.black),
                            selected: isSelected2),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          vertical: CustomSizes().dynamicHeight(context, 0),
                        ),
                        itemCount: isSelected1 == true && isSelected2 == false
                            ? newOrders.length
                            : isSelected2 == true && isSelected1 == false
                                ? pickedOrders.length
                                : snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return activeOrderCard(
                              context,
                              isSelected1 == true && isSelected2 == false
                                  ? newOrders
                                  : isSelected2 == true && isSelected1 == false
                                      ? pickedOrders
                                      : snapshot.data,
                              index,
                              setState);
                        },
                      ),
                    ),
                  ],
                );
              });
            }
          } else {
            return const Loader();
          }
        }),
  );
}

Widget activeOrderCard(BuildContext context, snapshot, index, setState) {
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
    child: Container(
      margin: const EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.05),
        vertical: CustomSizes().dynamicHeight(context, 0.01),
      ),
      decoration: BoxDecoration(
          color: snapshot[index]["status"] == "returned-pending"
              ? Colors.red.withOpacity(0.05)
              : CustomColors.customGreen.withOpacity(0.05),
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                  context,
                  "PKR. " +
                      double.parse(snapshot[index]["codAmount"].toString())
                          .toStringAsFixed(0),
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
                    "Order no #" + snapshot[index]["custRefNo"].toString(),
                    0.03,
                    CustomColors.customBlack),
              )
            ],
          ),
          text(context, snapshot[index]["consigneeName"].toString(), 0.04,
              CustomColors.customBlack),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                  context,
                  snapshot[index]["status"] == "returned-pending"
                      ? "Waiting for you to return the parcel"
                      : "Waiting for approval",
                  0.035,
                  snapshot[index]["status"] == "returned-pending"
                      ? Colors.red
                      : CustomColors.customGreen,
                  bold: true),
              InkWell(
                onTap: () async {
                  await launch("tel:${snapshot[index]["consigneeMobNo"]}");
                },
                child: const Icon(
                  Icons.phone,
                  color: CustomColors.customGreen,
                ),
              )
            ],
          ),
          text(context, "From :", 0.04, CustomColors.customBlack),
          Row(
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
                      horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                  child: text(
                      context,
                      snapshot[index]["pick_up_location"].toString(),
                      0.035,
                      CustomColors.customLightBlack,
                      bold: true),
                ),
              ),
            ],
          ),
          text(context, "To :", 0.04, CustomColors.customBlack),
          Row(
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
                      horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                  child: text(
                      context,
                      snapshot[index]["consigneeAddress"].toString(),
                      0.035,
                      CustomColors.customLightBlack,
                      bold: true),
                ),
              ),
            ],
          ),
          CustomSizes().heightBox(context, 0.02)
        ],
      ),
    ),
  );
}
