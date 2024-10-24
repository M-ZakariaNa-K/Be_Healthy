import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppVar {
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF226E4A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primary = Color(0xFF226E4A);
  static Color primarySoft = Color(0xFF5F997D);
  static Color primaryExtraSoft = Color(0xFFEFF3FC);
  static Color secondary = Color(0xFF94BBA8);
  static Color secondarySoft = Color(0xFFDBE8E2);
  static Color secondaryExtraSoft = Color(0xFFE9E9E9);
  static Color background = Color(0xFFFFFFFF);
  static Color error = Color(0xFFD00E0E);
  static Color success = Color(0xFF16AE26);
  static Color warning = Color(0xFFEB8600);
  static String LANG_CODE = 'en';
  static Map<String, String> trArr = {};
  static const VERSION_NUMBER = 60002000;
  static const VERSION_NUMBER_DOTTED = "0.2.0";
  //padding all
  static double distancePrimary = 10;
  static double paddingprimary = distancePrimary;
  static double marginprimary = distancePrimary;
  static double borderradiusprimary = distancePrimary + 5;
  //text colors
  static const textColor = Color(0xff37474F);
  static const seconndTextColor = Colors.white;
//fonts
  static FontWeight fontWeightBold = FontWeight.bold;
  static String fontFamily = "JetBrainsMono";
  static double mainFontSize = 18;
  static double littelFontSize = 14;
  //transation
  static Transition mainTransation = Transition.rightToLeft;

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF0F663C),
      textTheme: _textTheme(),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppVar.primaryExtraSoft,
        selectionColor: AppVar.primarySoft,
        cursorColor: AppVar.primary,
      ));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF0F663C),
      textTheme: _textTheme(),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppVar.primaryExtraSoft,
        selectionColor: AppVar.primarySoft,
        cursorColor: AppVar.primary,
      ));

  static TextTheme _textTheme() {
    return const TextTheme(
      // bodyLarge: TextStyle(fontFamily: "JetBrainsMono"),
      bodyLarge: TextStyle(fontFamily: "ABeeZee"),
      bodyMedium: TextStyle(fontFamily: "ABeeZee"),
      labelLarge: TextStyle(fontFamily: "ABeeZee"),
      titleLarge: TextStyle(fontFamily: "ABeeZee"),
      titleMedium: TextStyle(fontFamily: "ABeeZee"),
      headlineLarge: TextStyle(fontFamily: "ABeeZee"),
      headlineMedium: TextStyle(fontFamily: "ABeeZee"),
    );
  }
}

/*
to make colors for dark and light modes
Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : ThemesStyles.secondary, */
