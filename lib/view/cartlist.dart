import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/showcartlistitem.dart';
import 'package:flutter_ecommerce/widget/bottom-navigation-bar.dart';
import 'package:flutter_ecommerce/widget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartList extends StatefulWidget {
  CartList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  CartListState createState() => CartListState();
}

class CartListState extends State<CartList> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  ScrollController scrollController = new ScrollController();

  int _selectedIndex = 1;




  addListView() {
    DatabaseHelper databaseHelper = new DatabaseHelper();

    return FutureBuilder<List>(
        future: databaseHelper.getCartList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if(snapshot.data == null){
            new Center(child: new CircularProgressIndicator(),);
          }else{
            if(snapshot.data.length == 0){
              return Center(
                child: Text('You Dont Have Any Item Yet', style: TextStyle(color: Colors.blue),),
              );
            }
            _save(snapshot.data.length.toString());
          }
          return snapshot.hasData
              ? new ItemList(list: snapshot.data)
              : new Center(
            child: new CircularProgressIndicator(),
          );
        });
  }


  @override
  initState(){
    super.initState();
    readCartList();
//    scrollController.addListener(() {
//      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
//        print('${scrollController.position.pixels}');
//      }
//    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart List',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Cart List'),
            actions: <Widget>[
               IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: ()=> Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new HomePage(),
                    )
                ),
              ),
            ],
          ),
          body: Container(
//            height: MediaQuery.of(context).size.height,
//            width: MediaQuery.of(context).size.width,
            child: addListView(),
            margin: EdgeInsets.only(bottom: 50),
          ),
        drawer: Drawer(
          child: DrawerNavigationState(),
        ),
          bottomSheet: Container(
            width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: FlatButton(
            onPressed: (){
              Fluttertoast.showToast(
                  msg: "Checked Out",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
            color: Colors.blue,
            child: new Text(
              'Check Out',
              style: new TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.blue),),
          ),
      ),
        bottomNavigationBar:NavigationBottom(number: _selectedIndex , ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {

  ScrollController scrollController = new ScrollController();

  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GridView.builder(
      controller: scrollController,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
//      scrollDirection: Axis.vertical,
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context , i){
          return new Container(
//            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: ()=> Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new ShowCartList(list:list , index:i , number:1)
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
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(list[i]['name'] , style: TextStyle(color: Colors.blue),),
                          Padding(padding: EdgeInsets.all(10.0),),
                          Text(list[i]['price'] + ' ' + 'LE' , style: TextStyle(color: Colors.blue),),
                        ],
                      ),
                    ],
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
  final key = 'cartlistcount';
  final value = counter1;
  prefs.setString(key,value);
}
// Get Token With SharedPreferences
readCartList() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'cartlistcount';
  final value = prefs.get(key) ?? 0;
  return value.toString();
}


getData(){

}












