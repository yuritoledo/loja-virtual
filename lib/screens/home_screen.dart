import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/custom_drawer.dart';
import 'package:lojavirtual/tabs/categories.dart';
import 'package:lojavirtual/tabs/home.dart';
import 'package:lojavirtual/widgets/cart_button.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(_pageController),
      floatingActionButton: CartButton(),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          HomeTab(),
          Categories(),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
