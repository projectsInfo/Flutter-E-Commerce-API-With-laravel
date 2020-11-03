import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/searchbar.dart';

class EditDataSearch extends StatefulWidget {
  List list;
  int index;
//  List lists;
  List search;
  bool number = false;

  EditDataSearch({this.index, this.list , this.search , this.number});

  @override
  EditDataSearchState createState() => EditDataSearchState();
}

class EditDataSearchState extends State<EditDataSearch> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  final _key = GlobalKey<FormState>();
  RegExp regExp = new RegExp(r'[0-9]');


  TextEditingController _nameController;
  TextEditingController _priceController ;
  TextEditingController _detailsController ;
  String image = '';
  String fileName = '';
  String base64 = '';

  @override
  void initState(){
    super.initState();
    _nameController = new TextEditingController(text: widget.number == true ? widget.list[widget.index].name : widget.search[widget.index].name);
    _priceController = new TextEditingController(text: widget.number == true ? widget.list[widget.index].price : widget.search[widget.index].price);
    _detailsController = new TextEditingController(text: widget.number == true ? widget.list[widget.index].details : widget.search[widget.index].details);

    fileName =  widget.number == true ? widget.list[widget.index].image : widget.search[widget.index].image;
    base64 =  widget.number == true ? widget.list[widget.index].tmp_name : widget.search[widget.index].tmp_name;
    image =  widget.number == true ? widget.list[widget.index].image : widget.search[widget.index].image;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Product',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Product'),
          actions: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new SearchList()));
                }
            ),
          ],
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(
                top: 62, left: 12.0, right: 12.0, bottom: 12.0),
            children: <Widget>[

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 50,
                      minRadius: 50,
                      backgroundImage: NetworkImage(
                        'http://flutterapisup.achilles-store.com/uploads/$image',
                      ),
                    ),
                  ],
                ),
              ),

              Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      maxLength: 6,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        hintText: 'Place your product name',
                        icon: new Icon(Icons.widgets),
                      ),
                      validator: (v){
                        if(v.isEmpty){
                          return 'input require';
                        }else
                          return null;
                      },
                      onSaved: (v){

                      },
                    ),


                    TextFormField(
                      controller: _detailsController,
                      keyboardType: TextInputType.name,
                      maxLength: 6,
                      decoration: InputDecoration(
                        labelText: 'Product Details',
                        hintText: 'Place your product details',
                        icon: new Icon(Icons.details),
                      ),
                      validator: (v){
                        if(v.isEmpty){
                          return 'input require';
                        }else
                          return null;
                      },
                      onSaved: (v){

                      },
                    ),


                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: InputDecoration(
                        labelText: 'Product Price',
                        hintText: 'Place your product price',
                        icon: new Icon(Icons.attach_money),
                      ),
                      validator: (v){
                        if(v.isEmpty){
                          return 'input require';
                        }if(!regExp.hasMatch(_priceController.text.trim())){
                          return 'please enter valid number';
                        }
                        else
                          return null;
                      },
                      onSaved: (v){

                      },
                    ),

                    new Padding(padding: EdgeInsets.only(top: 20),),

                  ],
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 44.0,)),

              Container(
                height: 50,
                child: new RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: (){
                    setState(() {
                      if(_key.currentState.validate()){
                        widget.number == true ?
                        databaseHelper.editData(widget.list[widget.index].id, _nameController.text.trim(),
                            _detailsController.text.trim(), _priceController.text.trim(),
                            fileName , base64) :
                        databaseHelper.editData(widget.search[widget.index].id, _nameController.text.trim(),
                            _detailsController.text.trim(), _priceController.text.trim(),
                            fileName , base64);
                        Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new SearchList(),
                            )
                        );
                      }
                    });
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Update',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 44.0,)),

            ],),

        ),
      ),
    );
  }
}
