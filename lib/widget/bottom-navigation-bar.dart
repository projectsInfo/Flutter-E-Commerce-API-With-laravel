import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/view/cartlist.dart';
import 'package:flutter_ecommerce/view/dashboard.dart';
import 'package:flutter_ecommerce/view/homepage.dart';
import 'package:flutter_ecommerce/view/mapApi.dart';
import 'package:flutter_ecommerce/view/wishlist.dart';

class NavigationBottom extends StatelessWidget {

  int number;

  NavigationBottom({this.number});

  @override
  Widget build(BuildContext context) {
//    int _selectedIndex = 0;

    void _onItemTapped(int index) {

        number = index;
        switch(index){
          case 0 :
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new HomePage(),
            ));
            break;
          case 1 :
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new CartList(),
            ));
            break;
          case 2 :
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new WishList(),
            ));
            break;
          case 3 :
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Dashboard(),
            ));
            break;
          case 4 :
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new MapApi(),
            ));
            break;
        }

    }

    return  BottomNavigationBar(
      iconSize: 20,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
//              backgroundColor: Colors.red,
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Cart'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Wish'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          title: Text('Dashboard'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          title: Text('Location'),
        ),
      ],
      currentIndex: number,
//          selectedItemColor: Colors.blue[800],
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
