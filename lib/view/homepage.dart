import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/cartlist.dart';
import 'package:flutter_ecommerce/view/searchbar.dart';
import 'package:flutter_ecommerce/view/wishlist.dart';
import 'package:flutter_ecommerce/widget/cartitems.dart';
import 'package:flutter_ecommerce/widget/bottom-navigation-bar.dart';
import 'package:flutter_ecommerce/widget/checkinternetconnection.dart';
import 'package:flutter_ecommerce/widget/drawer.dart';
import 'package:badges/badges.dart';
import 'package:flutter_ecommerce/widget/slider.dart';


class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, this.title}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  int _selectedIndex = 0;
//  InternetConnectionState internetConnectionState = new InternetConnectionState();
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Badge(
                  badgeContent: FutureBuilder(
                      future: readWishList(),
                      builder: (context, position) {
                        return Text(
                          position.data.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        );
                      }),
                  badgeColor: Colors.red,
                  animationType: BadgeAnimationType.scale,
                  animationDuration: Duration(seconds: 1),
                  shape: BadgeShape.circle,
                  position: BadgePosition(
                    end: 5.0,
                    top: 0,
                  ),
                  child: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new WishList(),
                        ));
                      }),
                ),
                Badge(
                  badgeContent: FutureBuilder(
                      future: readCartList(),
                      builder: (context, position) {
                        return Text(
                          position.data.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        );
                      }),
                  badgeColor: Colors.red,
                  animationType: BadgeAnimationType.scale,
                  animationDuration: Duration(seconds: 1),
                  shape: BadgeShape.circle,
                  position: BadgePosition(
                    end: 5.0,
                    top: 0,
                  ),
                  child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new CartList(),
                        ));
                      }),
                ),
              ],
            ),
          ],
        ),
//        body: Container(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),

                // Slider Widget
                SliderWidget(),
                // Show Internet Connection
                InternetConnection(),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton.icon(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          onPressed: (){
                            Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new SearchList(),
                            ));
                          },
                          icon: Icon(Icons.search, color: Colors.white,),
                          color: Colors.blue,
                          label: Text('Serach' , style: TextStyle(color: Colors.white),)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                SizedBox(
                  height: 200.0,
                  child: addListView(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
//              InternetConnection(),
              ],
            ),
//          ),
        ),
        drawer: Drawer(
          child: DrawerNavigationState(),
      ),
        bottomNavigationBar:NavigationBottom(number: _selectedIndex , ),
      ),
    );
  }

  addListView() {
    DatabaseHelper databaseHelper = new DatabaseHelper();
    return FutureBuilder<List>(
        future: databaseHelper.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
//            print(snapshot.error);
          if(snapshot.data == null){
            new Center(child: new CircularProgressIndicator(),);
          }else{
            if(snapshot.data.length == 0){
              return Center(
                child: Text('Please go to your dashboard and add your items', style: TextStyle(color: Colors.blue),),
              );
            }
          }
          return snapshot.hasData
              ? new HomeItemList(list: snapshot.data)
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        });
  }
}