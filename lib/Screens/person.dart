import 'package:courierapp/Screens/new_orders.dart';
import 'package:flutter/material.dart';

import '../DynamicSizes/dynamic_sizes.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topBar(context, "Profile"),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: DynamicSize().dynamicWidth(context, 0.05)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DynamicSize().heightBox(context, 0.05),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DynamicSize().dynamicWidth(context, 0.1)),
                child: const Text(
                  "Manan Sing",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DynamicSize().heightBox(context, 0.01),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DynamicSize().dynamicWidth(context, 0.1)),
                child: const Text(
                  "0305546975",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DynamicSize().heightBox(context, 0.03),
              const Text(
                "Main",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        DynamicSize().heightBox(context, 0.02),
        cards(context, Icons.person, "Person Detail", true),
        DynamicSize().heightBox(context, 0.01),
        cards(context, Icons.privacy_tip, "Privacy Policy", true),
        DynamicSize().heightBox(context, 0.01),
        cards(context, Icons.book, "Terms and Conditions", true),
        DynamicSize().heightBox(context, 0.01),
        cards(context, Icons.contact_support, "Contact Us", true),
        DynamicSize().heightBox(context, 0.01),
        cards(context, Icons.logout, "Logout", true),
      ],
    ));
  }
}
