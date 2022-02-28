import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Screens/orders.dart';
import 'package:courierapp/Screens/person.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  double iconSize = 0.05;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Orders(),
            NewOrders(),
            Profile(),
            //LocationDetails(),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: CustomSizes().dynamicHeight(context, 0.07),
        child: TabBar(
          labelStyle: const TextStyle(color: CustomColors.customGrey),
          unselectedLabelColor: CustomColors.customGrey,
          unselectedLabelStyle: const TextStyle(color: CustomColors.customGrey),
          controller: _tabController,
          labelColor: Colors.amber,
          indicatorColor: Colors.amber,
          tabs: const [
            Tab(
                text: "Order",
                icon: Icon(
                  Icons.list,
                  color: CustomColors.customGrey,
                )),
            Tab(
                text: "New Orders",
                icon: Icon(
                  Icons.new_releases,
                  color: CustomColors.customGrey,
                )),
            Tab(
                text: "Profile",
                icon: Icon(
                  Icons.person,
                  color: CustomColors.customGrey,
                )),
          ],
        ),
      ),
    );
  }
}
