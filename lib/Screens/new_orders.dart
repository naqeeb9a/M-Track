import 'package:courierapp/configs.dart/configs.dart';
import 'package:flutter/material.dart';

class NewOrders extends StatefulWidget {
  const NewOrders({Key? key}) : super(key: key);

  @override
  State<NewOrders> createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "New Order type"),
          DynamicSize().heigthBox(context, 0.01),
          cards(context, Icons.book, "Book a courier", false),
          DynamicSize().heigthBox(context, 0.01),
          cards(context, Icons.location_city, "Hyperlocal", false)
        ],
      ),
    );
  }
}

cards(context, icon, text, check) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(DynamicSize().dynamicWidth(context, 0.03)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding:
                  EdgeInsets.all(DynamicSize().dynamicWidth(context, 0.02)),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: check == false ? Colors.grey : Colors.transparent,
                      width: check == false ? 1 : 0),
                  borderRadius: BorderRadius.circular(
                      DynamicSize().dynamicWidth(context, 0.02))),
              child: Icon(
                icon,
                color: themeColor,
              ),
            ),
            DynamicSize().widthBox(context, 0.03),
            Text(text)
          ],
        ),
        const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
      ],
    ),
  );
}

topBar(context, text) {
  return Container(
    padding: EdgeInsets.only(
      top: DynamicSize().dynamicWidth(context, 0.12),
      left: DynamicSize().dynamicWidth(context, 0.05),
      right: DynamicSize().dynamicWidth(context, 0.05),
      bottom: DynamicSize().dynamicWidth(context, 0.04),
    ),
    color: themeColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: DynamicSize().dynamicWidth(context, 0.035),
          backgroundColor: Colors.white.withOpacity(0.3),
          child: Icon(
            Icons.arrow_back_ios,
            size: DynamicSize().dynamicWidth(context, 0.03),
            color: Colors.white,
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        CircleAvatar(
          radius: DynamicSize().dynamicWidth(context, 0.035),
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.arrow_back_ios,
            size: DynamicSize().dynamicWidth(context, 0.03),
            color: Colors.transparent,
          ),
        ),
      ],
    ),
  );
}
