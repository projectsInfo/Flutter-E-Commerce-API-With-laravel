import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/dashboard.dart';
import 'package:flutter_ecommerce/view/editdata.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/wishlist.dart';
import 'package:flutter_ecommerce/widget/rating.dart';

class ShowWishItem extends StatefulWidget {
  List list;
  int index;
  int number;

  ShowWishItem({this.index, this.list , this.number});

  @override
  ShowWishItemState createState() => ShowWishItemState();
}

class ShowWishItemState extends State<ShowWishItem> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  double rating ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item Details',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Item Details'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: ()=> Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => widget.number == 1 ?  new WishList() : new Dashboard(),
                  )
              ),
            )
          ],
        ),
        body: Container(
        child: ListView(
          padding: const EdgeInsets.only(
              top: 62, left: 12.0, right: 12.0, bottom: 12.0),
          children: <Widget>[

            Container(
              child: new CircleAvatar(
                maxRadius: 100,
                minRadius: 50,
                backgroundImage: NetworkImage(
//                  'http://flutter_ecommercesup.achilles-store.com/uploads/${widget.list[widget.index]['image']}',
                  'http://flutterapisup.achilles-store.com/uploads/${widget.list[widget.index]['image']}',
                ),
//                  imageUrl: 'http://flutter_ecommercesup.achilles-store.com/uploads/${widget.list[widget.index]['image']}',
//                  width: 70.0,
//                  height: 70.0,
//                  fit: BoxFit.cover,
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 20.0),),

            Container(
              child: new Text(
                "Name : ${widget.list[widget.index]['name']}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            new Padding(padding: new EdgeInsets.only(top: 20.0),),

            Container(
              child: new Text(
                "Price : ${widget.list[widget.index]['price']}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            new Padding(padding: new EdgeInsets.only(top: 20.0),),

            Container(
              child: new Text(
                "Details : ${widget.list[widget.index]['details']}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            new Padding(padding: new EdgeInsets.only(top: 20.0),),

//            Container(
//              child: new Text(
//                "Updated at : ${widget.list[widget.index]['updated_at']}",
//                textAlign: TextAlign.center,
//                overflow: TextOverflow.ellipsis,
//                style: TextStyle(fontWeight: FontWeight.bold),
//              ),
//            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new StarRating(
                  rating: double.parse(widget.list[widget.index]['rate']),
                  onRatingChanged: (rating) => setState(() => this.rating = rating),
                ),
              ],
            ),

            new Padding(padding: new EdgeInsets.only(top: 20.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  child: new FlatButton(
                    onPressed: ()=> Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new EditData(list:widget.list , index:widget.index),
                        )
                    ),
                    color: Colors.green,
                    child: new Text(
                      'Edit',
                      style: new TextStyle(
                        color: Colors.white,
                      ),),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0),),
                Container(
                  height: 50,
                  child: new FlatButton(
                    onPressed: () {
                      databaseHelper.deleteWishList(widget.list[widget.index]['id']);
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new Dashboard(),
                          )
                      );
                    },
                    color: Colors.red,
                    child: new Text(
                      'Delete',
                      style: new TextStyle(
                        color: Colors.white,
                      ),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      ),
    );
  }
}

















