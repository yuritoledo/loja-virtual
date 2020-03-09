import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/product.dart';

class CartData {
  String cid;
  String category;

  String pid;

  int quantity;

  String size;

  ProductData productData;

  CartData.fromDocument(DocumentSnapshot snapshot) {
    cid = snapshot.documentID;

    category = snapshot.data['category'];
    pid = snapshot.data['pid'];
    quantity = snapshot.data['quantity'];
    size = snapshot.data['size'];
    productData = snapshot.data['productData'];
  }

  Map<String, dynamic> toMap() {
    return {
      "cid": cid,
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "productData": productData.toResumedMap(),
    };
  }
}
