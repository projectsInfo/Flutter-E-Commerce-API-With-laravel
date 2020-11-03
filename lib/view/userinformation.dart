import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/Controllers/wordpresshelper.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
class UserInformation extends StatefulWidget {

  UserInformation({Key key, this.title}) : super(key: key);
  final String title;

  @override
  UserInformationState createState() => UserInformationState();
}

class UserInformationState extends State<UserInformation> {

  DatabaseHelper databaseHelper = new DatabaseHelper();
  WordPressHelper wordPressHelper = new WordPressHelper();
  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Information',
      home: Scaffold(
          appBar: AppBar(
            title: Text('User Information'),
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
          body: Container(
            child: FutureBuilder(
              future: databaseHelper.getUserInformation(),
              builder: (context ,snapshot){
                if(snapshot.hasData){
                    return ListView.builder(itemCount : snapshot.data.length,
                          itemBuilder: (BuildContext context , int index){
                              Map data = snapshot.data[index];
//                            String id = data['id'].toString();
                            String Image = data['image'];
                              String name = data['name'];
                              String email = data['email'];
                              return Card(
                                child : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                    child : Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: CircleAvatar(
                                            maxRadius: 100,
                                            minRadius: 100,
                                            backgroundImage: NetworkImage(
//                                              'http://flutter_ecommercesup.achilles-store.com/uploads/$Image',
                                              'http://flutterapisup.achilles-store.com/uploads/$Image',
//                                                'http://flutter_ecommercesup.achilles-store.com/uploads/image_picker-2132300484.jpg'
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top:20),),
                                        Container(
                                        child: Text(name, style: TextStyle(color: Colors.blue , fontSize: 20),),
                                        ),
                                        Padding(padding: EdgeInsets.only(top:20),),
                                        Container(
                                          child: Text(email, style: TextStyle(color: Colors.blue , fontSize: 20),),
                                        ),
                                      ],
                                    )
                                )
                              );
                          }
                    );
                }else{
                  return  new Center(
                    child: new CircularProgressIndicator(),
                  );
                }
              }
            ),
          ),
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
              child: new Card(
                child: new ListTile(
                  title: new Text(list[i]['name']),
                  leading: new CircleAvatar(
                    maxRadius: 30,
                    minRadius: 30,
                    backgroundImage: NetworkImage(
                      'http://flutter_ecommercesup.achilles-store.com/uploads/${list[i]['image']}',
                    ),
                  ),
                  subtitle: new Text('Price : ${list[i]['name']}'),
                ),
              ),
            ),
          );
        }
    );
  }
}
