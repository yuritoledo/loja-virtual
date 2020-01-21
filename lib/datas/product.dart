import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;

  String category;

  String title;
  String description;

  double price;

  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;

    title = snapshot.data['title'];
    description = snapshot.data['description'];
    price = double.parse(snapshot.data['price'].toString());

    images = snapshot.data['images'];
    sizes = snapshot.data['sizes'];
  }
}
