import 'package:courierapp/Khubaib/active_order.dart';
import 'package:courierapp/utils/config.dart';
import 'package:flutter/material.dart';

class CustomSearchDeligate extends SearchDelegate {
  final dynamic snapshot;
  final bool isSelected1, isSelected2;
  final VoidCallback setState;
  final List newOrders, pickedOrders;
  CustomSearchDeligate(this.snapshot, this.isSelected1, this.isSelected2,
      this.setState, this.newOrders, this.pickedOrders);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: InputBorder.none, enabledBorder: InputBorder.none),
        appBarTheme: const AppBarTheme(color: CustomColors.customYellow),
        scaffoldBackgroundColor: const Color(0xFFf7ecbe));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List matchQuery = [];
    for (var item in snapshot) {
      if (item["tracking_number"]
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ActiveOrderList(
              isSelected1: isSelected1,
              isSelected2: isSelected2,
              setState: setState,
              newOrders: newOrders,
              pickedOrders: pickedOrders,
              snapshot: matchQuery),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];
    for (var item in snapshot) {
      if (item["tracking_number"]
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ActiveOrderList(
              isSelected1: isSelected1,
              isSelected2: isSelected2,
              setState: setState,
              newOrders: newOrders,
              pickedOrders: pickedOrders,
              snapshot: matchQuery),
        ),
      ],
    );
  }
}
