import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/showdata.dart';
import 'package:flutter_ecommerce/view/wishlist.dart';

class HomeItemList extends StatelessWidget {
  List list;
  var color = 0xff453658;

  HomeItemList({this.list});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: new ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: list == null ? 0 : list.length,
          itemBuilder: (context, i) {
            return  Container(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ShowData(
                          list: list,
                          index: i,
                          number : 1
                        )),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 200,
                    child: Card(
                      shadowColor: Colors.red,
                      elevation: 10,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            maxRadius: 40,
                            minRadius: 40,
                            backgroundImage: NetworkImage(
//                                'http://flutter_ecommercesup.achilles-store.com/uploads/${list[i]['image']}',
                              'http://flutterapisup.achilles-store.com/uploads/${list[i]['image']}',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                list[i]['name'],
                                style: TextStyle(
                                    fontSize: 15, color: Colors.blue),
                              ),
//
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                              ),
                              Text(list[i]['details'],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue)),
//
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                              ),
                              Text(list[i]['price'] + ' ' + 'LE',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue)),
                            ],
                          ),

                          IconButton(
                            color: Colors.green,
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                              DatabaseHelper databaseHelper =
                              new DatabaseHelper();

                              File image = File(
                                  'http://flutterapisup.achilles-store.com/uploads/${list[i]['image']}');
                              String fileName = image.path
                                  .split('/')
                                  .last;
                              String imagebase64 = list[i]['tmp_name'];

                              print('Showdataimage : $image ' '$imagebase64');
                              print('Showdataimage :   $imagebase64');

                              databaseHelper.addWishList(
                                  list[i]['name'],
                                  list[i]['details'],
                                  list[i]['price'],
                                  fileName,
                                  imagebase64,
                                  list[i]['rate']);

                              Navigator.of(context)
                                  .push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                new WishList(),
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            );
          }),
    );
  }
}
