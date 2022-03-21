import 'dart:convert';

import 'package:courierapp/Khubaib/personal_detail.dart';
import 'package:courierapp/Screens/login.dart';
import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Screens/pick_up_centers.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isActive = false;
  Map riderData = {};
  getRiderInfo() async {
    SharedPreferences isRiderActive = await SharedPreferences.getInstance();
    SharedPreferences userData = await SharedPreferences.getInstance();

    if (isRiderActive.getBool("isActive") != null) {
      setState(() {
        riderData = jsonDecode(userData.getString("user").toString());
        isActive = isRiderActive.getBool("isActive")!;
      });
    } else {
      setState(() {
        riderData = jsonDecode(userData.getString("user").toString());
        isActive = false;
      });
    }
  }

  @override
  void initState() {
    getRiderInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/mtrack.png",
            width: CustomSizes().dynamicWidth(context, 0.3),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05),
                vertical: CustomSizes().dynamicWidth(context, 0.02)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizes().heightBox(context, 0.05),
                Hero(
                  tag: 1,
                  child: riderData.isEmpty
                      ? Container()
                      : CircleAvatar(
                          radius: CustomSizes().dynamicWidth(context, 0.07),
                          backgroundImage:
                              NetworkImage(riderData["data"]["image"]),
                        ),
                ),
                SwitchListTile(
                  title: text(
                      context,
                      riderData.isEmpty
                          ? "...."
                          : riderData["data"]["name"].toString(),
                      0.04,
                      CustomColors.customBlack),
                  onChanged: (value) async {
                    SharedPreferences isRiderActive =
                        await SharedPreferences.getInstance();
                    setState(() {
                      isRiderActive.setBool("isActive", value);
                      isActive = value;
                    });

                    var res = await RiderFunctionality()
                        .riderOnline(query: "is-active", isActive: isActive);
                    if (res == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: text(
                              context,
                              "Check Your internet or Try again",
                              0.04,
                              CustomColors.customWhite)));
                      setState(() {
                        isRiderActive.setBool("isActive", false);
                        isActive = false;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: text(
                              context,
                              isActive == true
                                  ? "You are online"
                                  : "You are offline",
                              0.04,
                              CustomColors.customWhite)));
                    }
                  },
                  value: isActive,
                ),
                CustomSizes().heightBox(context, 0.03),
              ],
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.person,
            "Person Detail",
            true,
            check2: true,
            function: () => CustomRoutes().push(
                context,
                PersonalDetails(
                  riderDetails: riderData["data"],
                )),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(context, Icons.business_center_sharp, "Pick-up centers", true,
              check2: true, function: () {
            CustomRoutes().push(context, const PickUpCenters());
          }),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.privacy_tip,
            "Privacy Policy",
            true,
            check2: true,
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(context, Icons.book, "Terms and Conditions", true,
              check2: true),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.contact_support,
            "Contact Us",
            true,
            check2: true,
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(context, Icons.logout, "Logout", true, check2: true,
              function: () async {
            SharedPreferences userData = await SharedPreferences.getInstance();
            userData.clear();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Login()));
          }),
        ],
      ),
    ));
  }
}
