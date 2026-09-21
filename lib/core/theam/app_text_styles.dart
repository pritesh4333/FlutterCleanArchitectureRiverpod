import 'package:flutter/material.dart';
import 'app_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heading = TextStyle(
    fontFamily: AppFonts.rethinkSans,
    fontWeight: FontWeight.w700, // 👈 bold — maps to RethinkSans-Bold.ttf
    fontSize: 24,
  );

  static const TextStyle body = TextStyle(
    fontFamily: AppFonts.rethinkSans,
    fontWeight: FontWeight.w400, // regular
    fontSize: 16,
  );

  static const TextStyle bodyBold = TextStyle(
    fontFamily: AppFonts.rethinkSans,
    fontWeight: FontWeight.w700, // bold variant of body
    fontSize: 16,
  );
}