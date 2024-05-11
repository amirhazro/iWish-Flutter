import 'package:flutter/material.dart';

class ThemeColors {
  static final ThemeColors _sharedInstance = ThemeColors._internal();

  factory ThemeColors() {
    return _sharedInstance;
  }
  ThemeColors._internal();

  //Define Colors Below
  Color primaryColor = const Color(0xFF2458D5);
  Color transparent = const Color.fromARGB(0, 255, 255, 255);
  Color white = const Color(0xFFFFFFFF);
  Color black = const Color(0xFF000000);
  Color grey = const Color(0xFF7B7B7B);
  Color greyBorder = const Color(0xFFE1E1E1);
  Color greyDivider = const Color(0xFFC8C8C8);
  Color greyUnderline = const Color(0xFFD9D9D9);
  Color greySocialButtons = const Color(0xFFE9EEED);
  Color greyLight = const Color(0xFF868686);
  Color errorRed = const Color(0xFFEE1111);
  Color greyDropDownValue = const Color(0xFF848484);
  Color greyAddress = const Color(0xFFABB0AF);
  Color greySwichBg = const Color(0xFFD1D1D1);
  Color greySmall = const Color(0xFFA7A7A7);
  Color greyborder = const Color(0xFFEDEDED);
  Color unratedGrey = const Color(0xFFF6F6F6);
  Color cultured = const Color(0xFFF8F8F8);
  Color culturedTwo = const Color(0xFFF7F7F7);
  Color spanishGray = const Color(0xFF9E9E9E);
  Color antiFlashWhite = const Color(0xFFF3F3F3);
  Color lightGray = const Color(0xFFD2D2D2);
  Color sweetBrown = const Color(0xFFAA3838);
  Color peachOrange = const Color(0xFFFFC896);
  Color brightGray = const Color(0xFFEBEBEB);
  Color philippineGray = const Color(0xFF8C8C8C);
  Color philippineGray2 = const Color(0xFF909090);
  Color eerieBlack = const Color(0xFF1E1E1E);
  Color platinum = const Color(0xFFE7E7E7);
  Color platinum2 = const Color(0xFFE7E4E9);
  Color graniteGray = const Color(0xFF606060);
  Color newCar = const Color(0xFF2458D5);
  Color argent = const Color(0xFFBFBFBF);
  Color dimGray = const Color(0xFF696969);
  Color silverChalice = const Color(0xFFACACAC);

  Color blackLightColor = const Color(0xFF333333);
  Color blackVersionTwo = const Color(0xFF001F1C);

  Color greyBottomBar = const Color(0xFFA8A8A8);
  Color thumbActiveColorOne = const Color(0xFFF2985B);
  Color thumbActiveColorTwo = const Color(0xFFDA5E98);

  Color lightRed = const Color(0xFFFEF1EE);

  Color toggleSwitchThumbColorActive = const Color(0xFF4B41A8);
  Color toggleSwitchThumbColorInActive = const Color(0XFF474747);
  Color toggleSwitchBorderColor = const Color(0xFF433C90);
  Color toggleSwitchBackgroundColorActive = const Color(0xFFBCB4FF);
  Color toggleSwitchBackgroundColorInactive = const Color(0xFF000000);

  //PrimaryColors
  Color primaryColorOne = const Color(0xFFBCBFFF);
  Color primaryColorTwo = const Color(0xFFFFFEEC);
  Color primaryColorThree = const Color(0xFFE9FC87);
  Color primaryColorFour = const Color(0xFF000000);

  //SecondaryColors
  Color secondaryColorOne = const Color(0xFFE8E8E8);
  Color secondaryColorTwo = const Color(0xFFFFB985);
  Color secondaryColorThree = const Color(0xFFEBD4F8);

  //HomeTopCard Colors
  Color homeTopCardColorOne = const Color(0xFFF37253);
  Color homeTopCardTextColor = const Color(0xFF414141);

  Color purpleLight = const Color(0xFF958DD8);

  //ModalBottomSheetOverlayBackgroundColor
  Color modalBackgroundBottomSheetColor = const Color(0xFFCDCDCD);

  //AdressTextFieldColor
  Color addressTextFieldBackgroundColor = const Color(0xFFF7FAFA);
  Color addressSelectionScreenBackground = const Color(0xFFFBFBFB);

  Color lavenderBlue = const Color(0xFFC4BEFF);
  Color veryLightBlue = const Color(0xFF5666F3);
}
