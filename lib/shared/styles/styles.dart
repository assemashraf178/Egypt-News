import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightMode() => ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backwardsCompatibility: false,
        titleSpacing: 0.0,
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        brightness: Brightness.light,
        centerTitle: true,
      ),
      fontFamily: 'Jannah',
      hintColor: Colors.grey[400],
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      splashColor: Colors.white,
      primarySwatch: defaultColor,
      scaffoldBackgroundColor: Colors.white,
    );

ThemeData darkMode() => ThemeData(
      fontFamily: 'Jannah',
      appBarTheme: AppBarTheme(
        backgroundColor: HexColor('333739'),
        elevation: 0.0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        ),
        backwardsCompatibility: false,
        titleSpacing: 0.0,
        actionsIconTheme: const IconThemeData(
          color: Colors.white,
        ),
        brightness: Brightness.light,
        centerTitle: true,
      ),
      hintColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      splashColor: HexColor('333739'),
      primarySwatch: defaultColor,
      scaffoldBackgroundColor: HexColor('333739'),
      textTheme: const TextTheme(
        caption: TextStyle(
          color: Colors.white,
        ),
        headline5: TextStyle(
          color: Colors.white,
        ),
      ),
    );
