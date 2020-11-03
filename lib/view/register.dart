import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/login.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {

  DatabaseHelper databaseHelper = new DatabaseHelper();

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  final _key = GlobalKey<FormState>();
  RegExp regExp = new RegExp(r'(^(?:[+0]11)?[0-9]{11}$)');
  RegExp regExpEmail = new RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery ,maxHeight: 100 , maxWidth: 100);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  String msgStatus = '';
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(
                top: 62, left: 12.0, right: 12.0, bottom: 12.0),
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              showImage(),
              SizedBox(
                height: 10.0,
              ),

              IconButton(
                onPressed: chooseImage,
                color: Colors.blue,
                icon: Icon(Icons.camera_alt),
              ),
              Form(
              key: _key,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Place your name',
                        icon: new Icon(Icons.person),
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

                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Place your email',
                        icon: new Icon(Icons.email),
                      ),
                      validator: (v){
                        if(v.isEmpty){
                          return 'input require';
                        }if(!regExpEmail.hasMatch(_emailController.text.trim())){
                          return 'Please enter valid email';
                        }else
                          return null;
                      },
                      onSaved: (v){

                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Place your password',
                        icon: new Icon(Icons.vpn_key),
                      ),
                      validator: (v){
                        if(v.isEmpty){
                          return 'input require';
                        }if(_passwordController.text.length < 6){
                              return 'Please enter 6 characters';
                        }else
                          return null;
                      },
                      onSaved: (v){

                      },
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: _phoneController,
                      maxLength: 11,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: 'Place your phone',
                        icon: new Icon(Icons.phone),
                      ),
                      validator: (v){
                        if(v.isEmpty){
                          return 'input require';
                        }if(!regExp.hasMatch(_phoneController.text.trim())){
                          return 'Please enter valid mobile number';
                        }else
                          return null;
                      },
                      onSaved: (v){
                      },
                    ),
                  ],
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 44.0,)),

              Container(
                height: 50,
                child: new FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: (){
                    _onPressed();
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Register',
                    style: new TextStyle(
                      color: Colors.white,
                    ),),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0,)),
              Container(
                height: 50,
                child: new FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: ()=> Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new LoginPage(),
                      )
                  ),
                  color: Colors.blue,
                  child: new Text(
                    'Login',
                    style: new TextStyle(
                      color: Colors.white,
                    ),),
                ),
              ),
            ],),
        ),
      ),
    );
  }



  _onPressed() {
    setState(() {
      if ( _key.currentState.validate()) {
        setStatus('Uploading Image...');
        if (tmpFile == null) {
          _showImageDialog();
        }



        // Upload Data Of Image
        String fileName = tmpFile.path.split('/').last;
        String base64 = base64Encode(tmpFile.readAsBytesSync());

        databaseHelper.registerData(fileName, base64,
            _nameController.text.trim(),
            _emailController.text.trim().toLowerCase(),
            _passwordController.text.trim(),
            _phoneController.text.trim()).whenComplete(() {
          if (databaseHelper.status) {
            _showDialog();
//            msgStatus = 'Check email or password';
          } else {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) => new HomePage())
            );

          }
        });
      }
    });
  }

  void _showDialog(){
    showDialog(
        context : context,
        builder : (BuildContext context){
          return AlertDialog(
            title: new Text('Failed'),
            content: new Text('Your email is alredy exist'),
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













