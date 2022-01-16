import 'package:courierapp/Screens/orders.dart';

import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Screens/person.dart';
import 'package:courierapp/configs.dart/configs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int value = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.99),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: value,
          onTap: (index) {
            setState(() {
              value = index;
              _pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut);
            });
          },
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          selectedItemColor: themeColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.pages,
                ),
                label: "Orders"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.medical_services,
                ),
                label: "New Order"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile"),
          ],
        ),
        body: pageDecider());
  }

  pageDecider() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          value = index;
        });
      },
      children: [page1(), page2(), page3()],
    );
  }
}

colorfulButton(context, text, buttonColor, borderColor, fontWeight,
    {function = ""}) {
  return InkWell(
    onTap: function == "" ? () {} : function,
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: borderColor),
                color: buttonColor,
                borderRadius: BorderRadius.circular(
                    DynamicSize().dynamicWidth(context, 0.1))),
            padding: EdgeInsets.all(DynamicSize().dynamicWidth(context, 0.035)),
            child: Center(
                child: Text(
              text,
              style: TextStyle(fontWeight: fontWeight),
            )),
          ),
        ),
      ],
    ),
  );
}

page2() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NewOrders(),
  );
}

page1() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Orders(),
  );
}

page3() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Profile(),
  );
}
