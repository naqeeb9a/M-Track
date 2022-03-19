import 'package:courierapp/Khubaib/active_order.dart';
import 'package:courierapp/Khubaib/completed.dart';
import 'package:courierapp/Khubaib/pending_orders.dart';
import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Screens/person.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: customAppbar(
            context: context,
            text1: "Orders",
            automaticallyImplyLeading: true,
            backgroundColor: CustomColors.customYellow,
            showRiderStatus: true,
          ),
          drawer: const Drawer(
            child: Profile(),
          ),
          body: Column(
            children: [
              Container(
                height: CustomSizes().dynamicHeight(context, 0.06),
                color: CustomColors.customWhite,
                child: const TabBar(
                  indicatorColor: CustomColors.customYellow,
                  labelColor: CustomColors.customBlack,
                  unselectedLabelColor: CustomColors.customGrey,
                  tabs: [
                    Tab(text: "Assigned"),
                    Tab(text: "Pending"),
                    Tab(text: "Completed"),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ActiveOrder(),
                    PendingOrders(),
                    CompletedOrder(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
