import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/cart.dart';
import 'package:lojavirtual/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<CartData> _products = [];
  UserModel _user;

  CartModel(this._user);

  int quantityItems() => _products.length;

  bool isLoading = false;

  List<CartData> get products => _products;

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartData cartData) {
    _products.add(cartData);
    Firestore.instance
        .collection('users')
        .document(_user.firebaseUser.uid)
        .collection('cart')
        .add({
          "category": cartData.category,
          "pid": cartData.pid,
          "quantity": 1,
          "size": cartData.size,
          "productData": cartData.productData.toResumedMap(),
        })
        .then((resp) => cartData.cid = resp.documentID)
        .catchError((error) => print(error));

    notifyListeners();
  }

  void removeCartItem(CartData cartData) {
    _products.remove(cartData);
    Firestore.instance
        .document(_user.firebaseUser.uid)
        .collection('cart')
        .document(cartData.cid)
        .delete();

    notifyListeners();
  }
}
