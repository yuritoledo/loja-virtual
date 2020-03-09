import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/cart.dart';
import 'package:lojavirtual/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<CartData> _products = [];
  UserModel _user;

  CartModel(this._user);

  void addCartItem(CartData cartData) {
    _products.add(cartData);
    Firestore.instance
        .document(_user.firebaseUser.uid)
        .collection('cart')
        .add(cartData.toMap())
        .then((resp) => cartData.cid = resp.documentID);

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
