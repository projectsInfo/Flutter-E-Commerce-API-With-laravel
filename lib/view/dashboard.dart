import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/adddata.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/showdata.dart';
import 'package:flutter_ecommerce/widget/bottom-navigation-bar.dart';
import 'package:flutter_ecommerce/widget/drawer.dart';
import 'dart:io';


class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  DatabaseHelper databaseHelper = new DatabaseHelper();
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new HomePage(),
                      )
                  );
                }
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
            onPressed: ()=> Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new AddData(),
                )
            ),
        ),
        body: new FutureBuilder<List>(
          future: databaseHelper.getData(),
          builder: (context ,snapshot){
            if(snapshot.hasError)
//              print(snapshot.error);
            if(snapshot.data == null){
              new Center(child: new CircularProgressIndicator(),);
            }else{
              if(snapshot.data.length == 0){
                return Center(
                  child: Text('Please Add New Items', style: TextStyle(color: Colors.blue),),
                );
              }
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
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
        itemBuilder: (context , i){
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: ()=> Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new ShowData(list:list , index:i ,)
                ),
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['name']),
                leading: new CircleAvatar(
                  maxRadius: 30,
                  minRadius: 30,
                  backgroundImage: NetworkImage(
                    'http://flutterapisup.achilles-store.com/uploads/${list[i]['image']}',
                  ),
                ),

                subtitle: new Text('Price : ${list[i]['price']}'),
                trailing: IconButton(
                  color: Colors.green,
                    icon: Icon(Icons.favorite),
                  onPressed: () {

                    DatabaseHelper databaseHelper = new DatabaseHelper();

                    File image = File('http://flutterapisup.achilles-store.com/uploads/${list[i]['image']}');
                    String fileName = image.path.split('/').last;
                    String imagebase64 = list[i]['tmp_name'];

                    databaseHelper.addWishList(list[i]['name'],
                        list[i]['details'], list[i]['price'],
                        fileName ,imagebase64 , list[i]['rate']);

                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new Dashboard(),
                        )
                    );
                  },
                ),
              ),
            ),
          ),
        );
        }
    );
  }
}













