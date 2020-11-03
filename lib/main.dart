import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/view/adddata.dart';
import 'package:flutter_ecommerce/view/cartlist.dart';
import 'package:flutter_ecommerce/view/dashboard.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/login.dart';
import 'package:flutter_ecommerce/view/register.dart';
import 'package:flutter_ecommerce/view/searchbar.dart';
import 'package:flutter_ecommerce/view/splashscreen.dart';
import 'package:flutter_ecommerce/view/wishlist.dart';
import 'package:flutter_ecommerce/view/userinformation.dart';
import 'package:flutter_ecommerce/view/mapApi.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(MyApp());
}

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title= '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      title: 'Flutter CRUD API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String,WidgetBuilder>{
        '/dashboard' :(BuildContext context) => new Dashboard(title:title),
        '/adddata' :(BuildContext context) => new AddData(title:title),
        '/register' :(BuildContext context) => new RegisterPage(title:title),
        '/login' :(BuildContext context) => new LoginPage(title:title),
        '/wishlist' :(BuildContext context) => new WishList(title:title),
        '/cartlist' :(BuildContext context) => new CartList(title:title),
        '/homepage' :(BuildContext context) => new HomePage(title:title),
        '/searchbar' :(BuildContext context) => new SearchList(),
        '/userinformation' :(BuildContext context) => new UserInformation(),
        '/mapApi' :(BuildContext context) => new MapApi(title:title),
      },
    );
  }
}



