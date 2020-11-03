import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/view/cartlist.dart';
import 'package:flutter_ecommerce/view/dashboard.dart';
import 'package:flutter_ecommerce/view/wishlist.dart';

class Taps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.dashboard),
                  text: 'Dashboard',
                ),
                Tab(
                  icon: Icon(Icons.shopping_cart),
                  text: 'Cart List',
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  text: 'Wish List',
                ),
              ],
            ),
            title: Text('Dashboard Taps'),
          ),
          body: TabBarView(
            children: [
              Dashboard(),
              CartList(),
              WishList(),
            ],
          ),
        ),
      ),
    );
  }
}