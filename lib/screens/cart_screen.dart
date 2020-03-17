import 'package:flutter/material.dart';
import 'package:lojavirtual/model/cart_model.dart';
import 'package:lojavirtual/model/user_model.dart';
import 'package:lojavirtual/screens/auth/login.dart';
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
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLogged()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLogged()) {
            return NotLogged();
          } else if (model.products == null || model.products.isEmpty) {
            return EmptyCart();
          }
          return Text('ja');
        },
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Nenhum item no carrinho!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NotLogged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.remove_shopping_cart,
              size: 80,
            ),
            SizedBox(height: 15),
            Text(
              'Faça login para adicionar itens no carrinho',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            RaisedButton(
                child: Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                })
          ],
        ),
      ),
    );
  }
}
