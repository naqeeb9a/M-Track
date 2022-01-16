import 'package:flutter/material.dart';

class DynamicSize {
  dynamicHeigth(context, heigth) {
    return MediaQuery.of(context).size.height * heigth;
  }

  dynamicWidth(context, width) {
    return MediaQuery.of(context).size.width * width;
  }

  heigthBox(context, heigth) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heigth,
    );
  }

  widthBox(context, width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }
}

class DynamicRoutes {
  push(context, page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}

var themeColor = Colors.amber;
