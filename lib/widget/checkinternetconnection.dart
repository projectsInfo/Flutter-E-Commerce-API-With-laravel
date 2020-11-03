import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
bool connection = false;

class InternetConnection extends StatefulWidget {
  InternetConnection({Key key, this.title}) : super(key: key);

  final String title;


  @override
  InternetConnectionState createState() => InternetConnectionState();
}

class InternetConnectionState extends State<InternetConnection> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {

      return
        Container(
//          child : Center(child: Text('Connection Status: $_connectionStatus')),
            child: connection == true ?  Center(
              child:   AlertDialog(
                title: Text('No Internet Connection'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Plaese Check Your internet Connection.'),
              ],
            ),
          ),
          actions: <Widget>[
          ],
        ),
            ) :
            Center(child: new Text(''))
        );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }

    if(result ==  ConnectivityResult.none){
       setState(() {
         connection = true;
       });
    }else{
      setState(() {
        connection = false;
      });
    }
  }
}