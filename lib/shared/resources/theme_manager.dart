import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

var lightTheme=ThemeData(
primarySwatch: Colors.blue,
primaryColor: Colors.blue,
scaffoldBackgroundColor: Colors.white,
appBarTheme: const AppBarTheme(
iconTheme: IconThemeData(color: Colors.black),
color: Colors.white,
elevation: 0,
systemOverlayStyle: SystemUiOverlayStyle(
statusBarColor: Colors.white,
statusBarIconBrightness: Brightness.dark,
),
titleTextStyle: TextStyle(
color: Colors.black,
fontSize: 18,
fontWeight: FontWeight.bold)),
textTheme: TextTheme(
bodyText1: TextStyle(
color: Colors.black,
fontSize: 18,
fontWeight: FontWeight.w600),
  subtitle1: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600

  )
),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
backgroundColor: Colors.white,
unselectedItemColor: Colors.grey,
selectedItemColor: Colors.deepOrange,
type: BottomNavigationBarType.fixed,
),
);


var darkTheme=
ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: Colors.deepOrange,
  primaryColor: Colors.deepOrange,
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    color: HexColor('333739'),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: HexColor('333739'),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.deepOrange,
    type: BottomNavigationBarType.fixed,
  ),
);