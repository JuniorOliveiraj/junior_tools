
import 'package:flutter/cupertino.dart';
import 'package:junior_tools/theme/export_boiler_plate.dart';

class KConstantColors {
  //! light
  static const greyColor = Color.fromRGBO(237, 237, 237, 1);
  static const whiteColor = Color.fromRGBO(250, 250, 250, 1);
  static var faintWhiteColor = whiteColor.withOpacity(0.5);

  //! dark
  static const bgColor = Color.fromRGBO(15, 15, 15, 1);
  static const bgColorFaint = Color.fromRGBO(30, 30, 30, 1);
  static var faintBgColor = bgColor.withOpacity(0.5);

  //! other
  static const appPrimaryColor = Color.fromRGBO(33, 54, 51,2);
  static const primaryColor = Color.fromRGBO(168, 168, 168, 2);
  static final greyColorBg =  Colors.grey.shade900;
  static const secondaryColor = appPrimaryColor;
  static const blueColor = Color.fromRGBO(39, 63, 60, 0.996);
  static const green = Color.fromRGBO(4, 149, 65, 1);
  static const redColor = CupertinoColors.systemRed;
}
