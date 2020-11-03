import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Controllers/databasehelper.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();


  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
//    print('read : $value');
    if(value != '0'){
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new HomePage(),
          )
      );
    }
  }

  @override
  initState(){
    super.initState();
    read();
  }

  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(
                top: 62, left: 12.0, right: 12.0, bottom: 12.0),
            children: <Widget>[
              Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Place your Email',
                        icon: new Icon(Icons.email),
                      ),
                      controller: _emailController,
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
                      height: 10
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Place your password',
                        icon: new Icon(Icons.vpn_key),
                      ),
                      validator: (v){
                        if(v.isEmpty){
                          return 'input require';
                        }else if(v.trim().length < 6){
                          return 'this password is too short';
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
            child: new RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: _onPressed,
              color: Colors.blue,
              child: new Text(
                'Login',
                style: new TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.blue),),
            ),
          ),

          new Padding(padding: new EdgeInsets.only(top: 44.0,)),

              Container(
                height: 50,
                child: new FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: ()=> Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new RegisterPage(),
                    )
                  ),
                  color: Colors.blue,
                  child: new Text(
                    'Register',
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
      if (_key.currentState.validate()) {
        _key.currentState.save();
        databaseHelper.loginData(_emailController.text.trim().toLowerCase(),
            _passwordController.text.trim()).whenComplete(() {
          if (databaseHelper.status) {
            _showDialog();
            msgStatus = 'Check your email or password';
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
            content: new Text('Check your email or password'),
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
  }







