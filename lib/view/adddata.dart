import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class AddData extends StatefulWidget {

  AddData({Key key, this.title}) : super(key: key);
  final String title;

  @override
  AddDataState createState() => AddDataState();
}

class AddDataState extends State<AddData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  final _key = GlobalKey<FormState>();
  String _rate;
  String _dropdownError;
  List<String> _list = ['1' , '2' , '3' , '4' , '5'];
  RegExp regExp = new RegExp(r'[0-9]');


  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _detailsController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _rateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Product',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Dashboard(),
                  ));
                }
            )
          ],
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(
                top: 62, left: 12.0, right: 12.0, bottom: 12.0),
            children: <Widget>[

              showImage(),

              SizedBox(
                height: 10.0,
              ),

              Container(
                height: 50,
                child: new IconButton(
                  color: Colors.blue,
                  onPressed: chooseImage,
                  icon: Icon(Icons.camera_alt),
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
                      }else
                        return null;
                    },
                    onSaved: (v){

                    },
                  ),

                  new Padding(padding: EdgeInsets.only(top: 20),),

                  Center(
                      child: DropdownButton(
                        hint: Text('Please choose a rate'), // Not necessary for Option 1
                        value: _rate,
                        onChanged: (newValue) {
                          setState(() {
                            _rate = newValue;
                          });
                        },
                        items: _list.map((rate) {

                          return DropdownMenuItem(
                            child: new Text(rate),
                            value: rate,
                          );
                        }).toList(),
                      ),
                  ),

                  _dropdownError == null
                      ? SizedBox.shrink()
                      : Text(
                    _dropdownError ?? "",
                    style: TextStyle(color: Colors.red),
                  ),

                ],
              ),
            ),

              new Padding(padding: new EdgeInsets.only(top: 44.0,)),
              Container(
                height: 50,
                child: new RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    setState(() {

                      if (_rate == null) {
                        setState(() => _dropdownError = "Please select a rate!");
                      }else{
                        setState(() => _dropdownError = "");
                      }

                      if( _key.currentState.validate() && _rate != null){
                        setStatus('Uploading Image...');


                        if (tmpFile == null) {
                          _showImageDialog();
                        }

                        // Upload Data Of Image
                        String fileName = tmpFile.path.split('/').last;
                        String base64 = base64Encode(tmpFile.readAsBytesSync());

                        databaseHelper.addData(_nameController.text.trim(),
                            _detailsController.text.trim(), _priceController.text.trim().toString(),
                            fileName , base64 , _rate);
//                        Navigator.of(context).push(
//                            new MaterialPageRoute(
//                              builder: (BuildContext context) => new Dashboard(),
//                            )
//                        );
                      Fluttertoast.showToast(msg: 'A new product has been added');
                      }
                    });
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Add',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
                ),
              ),

            ],),

        ),
      ),
    );
  }

  void _showImageDialog(){
    showDialog(
        context : context,
        builder : (BuildContext context){
          return AlertDialog(
            title: new Text('Failed'),
            content: new Text('Please Pick Your Image'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'Close',
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
//              fit: BoxFit.fill,
              width: 100.0,
              height: 100.0,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}