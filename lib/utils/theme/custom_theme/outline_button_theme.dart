import 'package:flutter/material.dart';
class DOutlineButtonTheme{
  DOutlineButtonTheme._();
  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.black,
    side: const BorderSide(color: Colors.blue),
    textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),
    padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
  )
  );
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.blueAccent),
          textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
      )
  );
}
