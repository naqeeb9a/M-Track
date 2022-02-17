import 'package:flutter/material.dart';

class DynamicSize {
  dynamicHeigth(context, heigth) {
    return MediaQuery.of(context).size.width * heigth;
  }

  dynamicWidth(context, width) {
    return MediaQuery.of(context).size.width * width;
  }

  heightBox(context, heigth) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * heigth,
    );
  }

  widthBox(context, width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }
}
