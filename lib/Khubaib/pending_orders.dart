import 'package:badges/badges.dart';
import 'package:courierapp/Widgets/buttons.dart';
import 'package:courierapp/Widgets/loader.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

import 'active_order.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customYellow.withOpacity(0.2),
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
                        Badge(
                          badgeContent: text(
                              context,
                              newOrders.length.toString(),
                              0.03,
                              CustomColors.customWhite),
                          animationType: BadgeAnimationType.scale,
                          child: ChoiceChip(
                              selectedColor: CustomColors.customYellow,
                              onSelected: (value) => changeState(() {
                                    isSelected1 = value;
                                  }),
                              label: text(context, "Delivered Pending", 0.03,
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
                              0.03,
                              CustomColors.customWhite),
                          animationType: BadgeAnimationType.scale,
                          child: ChoiceChip(
                              onSelected: (value) => changeState(() {
                                    isSelected2 = value;
                                  }),
                              selectedColor: CustomColors.customYellow,
                              label: text(context, "Returned Pending", 0.03,
                                  Colors.black),
                              selected: isSelected2),
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
