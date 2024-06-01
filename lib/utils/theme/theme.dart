
import 'package:flutter/material.dart';

import 'custom_theme/appbar_theme.dart';
import 'custom_theme/bottom_sheet_theme.dart';
import 'custom_theme/checkbox_theme.dart';
import 'custom_theme/chip_theme.dart';
import 'custom_theme/elevatedButton.dart';
import 'custom_theme/outline_button_theme.dart';
import 'custom_theme/text_theme.dart';
import 'custom_theme/textfield_theme.dart';
class DAppTheme{
  DAppTheme._();//constructor rieng tu de han che viec khoi tao object tuy y ma can thong qua factory
  static ThemeData light_theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: DTextTheme.lightTextTheme,
    elevatedButtonTheme: DEleveBtnTheme.lightEleBtnTheme,
    chipTheme: DChipTheme.lightChipTheme,
    appBarTheme: DAppBarTheme.ligthAppBarTheme,
    checkboxTheme: DCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: DBottomSheetTheem.lightBottomSheetThemeData,
    outlinedButtonTheme: DOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: DTextFieldTheme.lightTextFieldTheme
  );
  static ThemeData dark_theme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: DTextTheme.darkTextTheme,
      elevatedButtonTheme: DEleveBtnTheme.darkEleBtnTheme,
      chipTheme: DChipTheme.darkChipTheme,
      appBarTheme: DAppBarTheme.darkAppBarTheme,
      checkboxTheme: DCheckBoxTheme.darkCheckBoxTheme,
      bottomSheetTheme: DBottomSheetTheem.darkBottomSheetThemeData,
      outlinedButtonTheme: DOutlineButtonTheme.darkOutlineButtonTheme,
      inputDecorationTheme: DTextFieldTheme.darkTextFieldTheme
  );
}