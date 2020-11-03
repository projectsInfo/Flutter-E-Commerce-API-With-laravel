import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/cartlist.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/showwishltem.dart';
import 'package:flutter_ecommerce/widget/bottom-navigation-bar.dart';
import 'package:flutter_ecommerce/widget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class WishList extends StatefulWidget {
  WishList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  WishListState createState() => WishListState();
}

class WishListState extends State<WishList> {

  DatabaseHelper databaseHelper = new DatabaseHelper();

  int _selectedIndex = 2;

  @override
  initState(){
    readWishList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wish List',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Wish List'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: ()=> Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new HomePage(),
                    )
                ),
              )
            ],
          ),
          body: new FutureBuilder<List>(
            future: databaseHelper.getWishList(),
            builder: (context ,snapshot){
              if(snapshot.hasError)
//                print(snapshot.error);
              if(snapshot.data == null){
                new Center(child: new CircularProgressIndicator(),);
              }else{
                if(snapshot.data.length == 0){
                  return Center(
                    child: Text('You Dont Have Any Item Yet' , style: TextStyle(color: Colors.blue),),
                  );
                }else
                _save(snapshot.data.length.toString());
              }
              return snapshot.hasData
                  ? new ItemList(list : snapshot.data)
                  : new Center(child: new CircularProgressIndicator(),);
            },
          ),
        drawer: Drawer(
          child: DrawerNavigationState(),
        ),
        bottomNavigationBar: NavigationBottom(number: _selectedIndex , ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {

  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context , i){
          return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: ()=> Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new ShowWishItem(list:list , index:i , number: 1,)
                ),
              ),
              child: Container(
                child : Card(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        maxRadius: 35,
                        minRadius: 35,
                        backgroundImage: NetworkImage(
                          'http://flutterapisup.achilles-store.com/uploads/${list[i]['image']}',
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top : 5.0),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(list[i]['name'] , style: TextStyle(color: Colors.blue),),
                          Padding(padding: EdgeInsets.all(5.0),),
                          Text(list[i]['price']  + ' ' + 'LE' , style: TextStyle(color: Colors.blue),),
                        ],
                      ),

                      IconButton(
                        color: Colors.green,
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {

                          DatabaseHelper databaseHelper = new DatabaseHelper();

                          File image = File('http://flutterapisup.achilles-store.com/uploads/${list[i]['image']}');
                          String fileName = image.path.split('/').last;
                          String imagebase64 = list[i]['tmp_name'];

                          databaseHelper.addCartList(list[i]['name'],
                              list[i]['details'], list[i]['price'],
                              fileName ,imagebase64 , list[i]['rate']);

                          Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context) => new CartList(),
                              )
                          );
                        },
                      ),
                    ],
//                  title: new Text(list[i]['name']),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

_save(String counter1) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'wishlistcount';
  final value = counter1;
  prefs.setString(key,value);
}
// Get Token With SharedPreferences
readWishList() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'wishlistcount';
  final value = prefs.get(key) ?? 0;
  return value.toString();
}













