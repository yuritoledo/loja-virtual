import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FloatingActionButton(
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CartScreen()))));
  }
}
