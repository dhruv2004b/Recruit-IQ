import 'package:flutter/material.dart';

class AppColors {
static Color blackColor=Colors.black;
static Color whiteColor=Colors.white;
static Color greyColor= Colors.grey;
static Color oldColor=HexColor("#FFD919");
static Color g1=HexColor("#97E3A4");
static Color g2=HexColor("#14CFEC");
static Color lightBlueBg = HexColor('#E8F3FF');
static Color iconGrey = HexColor('#A2A2A2');
static Color lightGrey = HexColor('#c6c6c6');
static Color lightGreyBG = HexColor('#E9E9E9');
static Color bottomSheetBg = HexColor('#222222');
static Color unSelectBg = HexColor('#1D1D1D');


}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
