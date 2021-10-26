import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppTheme {
  static const String fontFamily = 'Tajawal';

  static const standardPadding = EdgeInsets.all(16);

  static const boxShadow = [BoxShadow(blurRadius: 22, color: Colors.black12, offset: Offset(0, 6))];

  static const double borderRadiusValue = 5.0;
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(borderRadiusValue));

  static InputDecoration getTextFieldDecoration({String? lable, String? hine, EdgeInsets? contentPadding}) {
    return InputDecoration(
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kGreyLight),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusValue),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kGreyDark),
        borderRadius: BorderRadius.circular(borderRadiusValue),
      ),
      labelText: lable,
      hintText: hine,
      isDense: true,
    );
  }

  static Decoration getContainerBorderDecoration() {
    return BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(borderRadiusValue));
  }

  static void setstatusBarColor({Color color = kCardBackground, Brightness? brightness}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: brightness ?? Brightness.dark,
    ));
  }

  static const flatButtonTextStyle1 = TextStyle(
    color: kAccentColor,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  static const numberStyle = TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: 'NumberFont', height: 1.1);
  static const linkStyle = TextStyle(fontSize: 15.0, color: Colors.blue, decoration: TextDecoration.lineThrough);
}
