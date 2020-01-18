import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesTiles extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoriesTiles(this.snapshot);

  @override
  Widget build(BuildContext context) {
    final data = snapshot.data;
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(data['icon']),
          backgroundColor: Colors.grey[200],
        ),
        title: Text(data['title']),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
