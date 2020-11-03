import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper{
  String serverUrl = "http://flutterapisup.achilles-store.com/api";
  var status;
  var token;

  // Login Function
  loginData(String email, String password) async{
    String myUrl = "$serverUrl/login1";
    final response = await http.post(myUrl,
        headers: {
          'Accept':'application/json'
        }, body: {
          "email":"$email",
          "password":"$password",
        });

    status = response.body.contains('error');

    var data = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  // Register Function
  registerData(String fileName ,String tmpName ,String name,String email, String password,String phone) async{
    String myUrl = "$serverUrl/register1";
    final response = await http.post(myUrl,
        headers: {
          'Accept':'application/json'
        }, body: {
          "image":"$fileName",
          "tmp_name":"$tmpName",
          "name":"$name",
          "email":"$email",
          "password":"$password",
          "phone":"$phone",
        });

    status = response.body.contains('error');

    var data = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

//======================================= Start Get and Edit and Show and Delete Data For Product ==========================================//

  //Show Product Function
  Future<List> getData() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/products/";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value'
        });
    return json.decode(response.body);
  }

  //Delete Product Function
  void deleteData(int id) async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;


    String myUrl = "$serverUrl/products/$id";
    http.delete(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value'
        }).then((response){
//      print('response status : ${response.statusCode}');
//      print('response body : ${response.body}');
    });
  }

  //Add Product Function
  void addData(String name, String details, String price , String fileName ,String tmpName , String rate) async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/products";

    http.post(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value',
        },
        body: {
          "name": "$name",
          "details": "$details",
          "price": "$price",
          "image": "$fileName",
          "tmp_name": "$tmpName",
          "rate": "$rate",
        }).then((response){
//      print('response status : ${response.statusCode}');
//      print('response body : ${response.body}');

    });
  }

  //Edit Product Function
  void editData(int id,String name, String details, String price , String image , String base64) async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;


    String myUrl = "$serverUrl/products/$id";
    http.put(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value'
        },
        body: {
          "name": "$name",
          "details": "$details",
          "price": "$price",
          "image": "$image",
          "base": "$base64",
        }).then((response){
//      print('response status : ${response.statusCode}');
//      print('response body : ${response.body}');
    });
  }

//======================================= End Get and Edit and Show and Delete Data For Product ==========================================//


//======================================= Start Get and Edit and Show and Delete Data For WishList ========================================//

  // Add To WishList
  void addWishList(String name, String details, String price , String fileName ,String tmpName , String rate) async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/wishes";

    http.post(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value',
        },
        body: {
          "name": "$name",
          "details": "$details",
          "price": "$price",
          "image": "$fileName",
          "tmp_name": "$tmpName",
          "rate": "$rate",
        }).then((response){
//      print('response status : ${response.statusCode}');
//      print('response body : ${response.body}');
    });
  }

  // Show WishList Data
  Future<List> getWishList() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/wishes/";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value'
        });
    return json.decode(response.body);
  }

  //Delete Product Function
  void deleteWishList(int id) async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;


    String myUrl = "$serverUrl/wishes/$id";
    http.delete(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value'
        }).then((response){
//      print('response status : ${response.statusCode}');
//      print('response body : ${response.body}');
    });
  }

//======================================= End Get and Edit and Show and Delete Data For WishList ========================================//

//======================================= Start Get and Edit and Show and Delete Data For CartList ========================================//


  // Show CartList Data
  Future<List> getCartList() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/carts/";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value'
        });
    return json.decode(response.body);
  }

  //Delete CartList Function
  void deleteCartList(int id) async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;


    String myUrl = "$serverUrl/carts/$id";
    http.delete(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value'
        }).then((response){
//      print('response status : ${response.statusCode}');
//      print('response body : ${response.body}');
    });
  }

// Add To CartList
  void addCartList(String name, String details, String price , String fileName ,String tmpName , String rate) async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/carts";

    http.post(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value',
        },
        body: {
          "name": "$name",
          "details": "$details",
          "price": "$price",
          "image": "$fileName",
          "tmp_name": "$tmpName",
          "rate": "$rate",
        }).then((response){
//      print('response status : ${response.statusCode}');
//      print('response body : ${response.body}');
    });
  }

// ======================================= Start Get and Edit and Show and Delete Data For CartList ========================================//


//======================================= Start User Information ========================================//



  Future<List> getUserInformation() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://flutterapisup.achilles-store.com/api/user";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $value'
        });

//    print(json.decode(response.body));

    return json.decode(response.body);
  }


//======================================= End User Information ========================================//

  // Save Token With SharedPreferences
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;

    prefs.setString(key,value);
  }
// Get Token With SharedPreferences
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');

  }
}