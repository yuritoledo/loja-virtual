import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/tiles/categories_menu_tiles.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('categories').getDocuments(),
        builder: (ctx, snap) {
          if (!snap.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return ListView(
              children: snap.data.documents.map((doc) {
            return CategoriesTiles(doc);
          }).toList());
        },
      ),
    );
  }
}
