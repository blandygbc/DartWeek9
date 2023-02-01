import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/ui/styles/app_styles.dart';
import 'package:vakinhaburger/app/core/ui/styles/colors_app.dart';
import 'package:vakinhaburger/app/core/ui/styles/text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: Colors.grey.shade400));

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    primaryColor: ColorsApp.instance.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.instance.primary,
      primary: ColorsApp.instance.primary,
      secondary: ColorsApp.instance.secondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.instance.primaryButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.all(13),
        border: _defaultInputBorder,
        enabledBorder: _defaultInputBorder,
        focusedBorder: _defaultInputBorder,
        labelStyle:
            TextStyles.instance.textRegular.copyWith(color: Colors.black)),
  );
}
