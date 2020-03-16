import 'package:flutter/material.dart';
import 'package:lojavirtual/model/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CARRINHO'),
        centerTitle: true,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 20),
              child: Center(
                child: ScopedModelDescendant<CartModel>(
                  builder: (context, child, model) {
                    final items = model.quantityItems();
                    final pluralize = items > 1 ? 'itens' : 'item';
                    return Text(
                      '$items $pluralize',
                      style: TextStyle(fontSize: 17),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
