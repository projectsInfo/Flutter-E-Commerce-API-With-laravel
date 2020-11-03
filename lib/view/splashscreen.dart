import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
//    print('read : $value');
    if(value != '0'){
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new HomePage(),
          )
      );
    }else{
      Timer(Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  LoginPage(),
              )
          )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    read();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}