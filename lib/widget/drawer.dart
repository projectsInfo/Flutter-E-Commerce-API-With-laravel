import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/cartlist.dart';
import 'package:flutter_ecommerce/view/dashboard.dart';
import 'package:flutter_ecommerce/view/login.dart';
import 'package:flutter_ecommerce/view/mapApi.dart';
import 'package:flutter_ecommerce/view/searchbar.dart';
import 'package:flutter_ecommerce/view/userinformation.dart';
import 'package:flutter_ecommerce/view/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
DatabaseHelper databaseHelper = new DatabaseHelper();


class DrawerNavigationState extends StatelessWidget {

  const DrawerNavigationState({
    Key key
  }) :super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[

              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child:  Container(
                  child: FutureBuilder(
                      future: databaseHelper.getUserInformation(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map data = snapshot.data[index];
//                                String id = data['id'].toString();
                                String Image = data['image'];
                                String name = data['name'];
                                String email = data['email'];
                                return Card(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: CircleAvatar(
                                                maxRadius: 30,
                                                minRadius: 30,
                                                backgroundImage: NetworkImage(
                                                  'http://flutterapisup.achilles-store.com/uploads/$Image',
//                                                    'http://flutter_ecommercesup.achilles-store.com/uploads/image_picker-2132300484.jpg'
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(name , style: TextStyle(color: Colors.blue),),
                                            ),
                                            Container(
                                              child: Text(email, style: TextStyle(color: Colors.blue),),
                                            ),
                                          ],
                                        )));
                              });
                        } else {
                          return new Center(
                            child: new CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ),
              ListTile(
                leading: Icon(Icons.assignment_ind , color: Colors.blue,),
                title: Text('User Information'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new UserInformation(),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.dashboard , color: Colors.blue,),
                title: Text('Dashboard'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Dashboard(),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart , color: Colors.blue,),
                title: Text('Cart List'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new CartList(),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite , color: Colors.blue,),
                title: Text('Wish List'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new WishList(),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.search , color: Colors.blue,),
                title: Text('Search'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new SearchList(),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on , color: Colors.blue,),
                title: Text('Our Location'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new MapApi(),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.keyboard_backspace , color: Colors.blue,),
                title: Text('LogOut'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  _save('0');
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginPage(),
                  ));
                },
              ),
            ],
          ),
    );
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }
}
