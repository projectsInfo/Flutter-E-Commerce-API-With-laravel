import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/Controllers/model.dart';
import 'package:flutter_ecommerce/view/dashboard.dart';
import 'package:flutter_ecommerce/view/editdata.dart';
import 'package:flutter_ecommerce/view/editdatasearch.dart';
import 'package:flutter_ecommerce/view/searchbar.dart';
import 'package:flutter_ecommerce/widget/rating.dart';

class SearchShowData extends StatefulWidget {
  int index;
  List list;
  List search;
  bool number = false;

  SearchShowData({this.index, this.list , this.search , this.number});

  @override
  SearchShowDataState createState() => SearchShowDataState();
}

class SearchShowDataState extends State<SearchShowData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  double rating ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Details',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: ()=> Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new SearchList(),
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
                    widget.number == true ?
                    'http://flutterapisup.achilles-store.com/uploads/${widget.list[widget.index].image}' :
                    'http://flutterapisup.achilles-store.com/uploads/${widget.search[widget.index].image}',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0),),

              Container(
                child: new Text(
                  widget.number == true ?
                  "Name : ${widget.list[widget.index].name}" :
                  "Name : ${widget.search[widget.index].name}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0),),

              Container(
                child: new Text(
                  widget.number == true ?
                  "Price : ${widget.list[widget.index].price}" :
                  "Price : ${widget.search[widget.index].price}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 20.0),),

              Container(
                child: new Text(
                  widget.number == true ?
                  "Details : ${widget.list[widget.index].price}" :
                  "Details : ${widget.search[widget.index].price}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 20.0),),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new StarRating(
                    rating: double.parse(widget.number == true ? widget.list[widget.index].rate : widget.search[widget.index].rate),
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
                            builder: (BuildContext context) => widget.number == true ? new EditDataSearch(list:widget.list , index:widget.index ,
                              number: true,) :
                            new EditDataSearch(search:widget.search , index:widget.index),
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
                        widget.number == true ?
                        databaseHelper.deleteData(widget.list[widget.index].id) :
                        databaseHelper.deleteData(widget.search[widget.index].id);
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

















