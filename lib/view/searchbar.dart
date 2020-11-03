import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/Controllers/model.dart';
import 'package:flutter_ecommerce/view/dashboard.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/searchshowdata.dart';
import 'package:flutter_ecommerce/view/showdata.dart';
import 'package:flutter_ecommerce/view/wishlist.dart';
import 'package:http/http.dart' as http;

//import 'package:search/model.dart';
import 'package:search_widget/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() {
//  runApp(MaterialApp(
//    home: SearchList(),
//    debugShowCheckedModeBanner: false,
//  ));
//}

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<Posts> _list = [];
  List<Posts> _search = [];
  var loading = false;

  // Drop Down List
  String _selectedLocation; // Option 2

  Future<Null> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    setState(() {
      loading = true;
    });

    _list.clear();

    final response =
//    await http.get("https://jsonplaceholder.typicode.com/posts");
        await http.get("http://flutterapisup.achilles-store.com/api/products/",
            headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
//      print('Data Cool Now :$data');
      setState(() {
        for (Map i in data) {
          _list.add(Posts.formJson(i));
          loading = false;
        }
      });
    } else {
      print('Data Null');
    }
  }

  TextEditingController controller = new TextEditingController();

//  DropdownButton dropController = new  DropdownButton(items: null, onChanged: (value) {  },);
//  DropdownMenuItem derood = new DropdownMenuItem(child: null);



//  DatabaseHelper databaseHelper = DatabaseHelper();
//  List<Posts> categoriesList ;
//  Posts _category;

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.name.toLowerCase().contains(text) || f.name.toUpperCase().contains(text) || f.id.toString().contains(text))
        _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>  new HomePage()));
              },
            ),
          ],
          title: Text('Search Items'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.blue,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      controller: controller,
                      onChanged: onSearch,
                      decoration: InputDecoration(
                          hintText: "Search", border: InputBorder.none),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        controller.clear();
                        onSearch('');
                      },
                      icon: Icon(Icons.cancel),
                    ),
                  ),
                ),
              ),
              Center(
                  child: DropdownButton(
                    hint: Text('Please choose a location'), // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                        onSearch(_selectedLocation.toLowerCase());
                      });
                    },
                    items: _list.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location.name),
                        value: location.name,
                      );
                    }).toList(),
                  )
              ),
              loading
                  ? Center(
                      child:  CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: _search.length != 0 || controller.text.isNotEmpty
                          ? ListView.builder(
                              itemCount: _search.length,
                              itemBuilder: (context, i) {
                                final b = _search[i];
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: ()=> Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) => new SearchShowData(search: _search, index:i ,)
                                      ),
                                    ),
                                    child: new Card(
                                      child: new ListTile(
                                        title: new Text(b.name),
                                        leading: new CircleAvatar(
                                          maxRadius: 30,
                                          minRadius: 30,
                                          backgroundImage: NetworkImage(
                                            'http://flutterapisup.achilles-store.com/uploads/${b.image}',
                                          ),
                                        ),
                                        subtitle: new Text('Price : ${b.price}'),
                                        trailing: IconButton(
                                          icon: Icon(Icons.favorite , color: Colors.green,),
                                          onPressed: () {
                                            DatabaseHelper databaseHelper =
                                                new DatabaseHelper();

                                            File image = File(
                                                'http://flutterapisup.achilles-store.com/uploads/${b.image}');
                                            String fileName =
                                                image.path.split('/').last;
                                            String imagebase64 = b.tmp_name;

                                            print('Showdataimage : $image '
                                                '$imagebase64');
                                            print('Showdataimage :   $imagebase64');

                                            databaseHelper.addWishList(
                                                b.name,
                                                b.details,
                                                b.price,
                                                fileName,
                                                imagebase64,
                                                b.rate);

                                            Navigator.of(context)
                                                .push(new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new WishList(),

                                            ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: _list.length,
                              itemBuilder: (context, i) {
                                final a = _list[i];
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: ()=> Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) => new SearchShowData(list: _list , index:i , number: true,)
                                      ),
                                    ),
                                    child: new Card(
                                      child: new ListTile(
                                        title: new Text(a.name),
                                        leading: new CircleAvatar(
                                          maxRadius: 30,
                                          minRadius: 30,
                                          backgroundImage: NetworkImage(
                                            'http://flutterapisup.achilles-store.com/uploads/${a.image}',
                                          ),
                                        ),
                                        subtitle: new Text('Price : ${a.price}'),
                                        trailing: IconButton(
                                          icon: Icon(Icons.favorite , color: Colors.green,),
                                          onPressed: () {
                                            DatabaseHelper databaseHelper =
                                            new DatabaseHelper();

                                            File image = File(
                                                'http://flutterapisup.achilles-store.com/uploads/${a.image}');
                                            String fileName =
                                                image.path.split('/').last;
                                            String imagebase64 = a.tmp_name;

                                            databaseHelper.addWishList(
                                                a.name,
                                                a.details,
                                                a.price,
                                                fileName,
                                                imagebase64,
                                                a.rate);

                                            Navigator.of(context)
                                                .push(new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              new WishList(),
                                            ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

