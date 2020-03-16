import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/product.dart';
import 'package:lojavirtual/screens/tiles/products_tiles.dart';
import 'package:lojavirtual/widgets/cart_button.dart';

class ProductsView extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ProductsView(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            floatingActionButton: CartButton(),
            appBar: AppBar(
              title: Text(snapshot['title']),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.grid_on)),
                  Tab(
                    icon: Icon(Icons.list),
                  ),
                ],
              ),
            ),
            body: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection('categories')
                  .document(snapshot.documentID)
                  .collection('items')
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 80.0,
                    width: 80.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return TabBarView(children: <Widget>[
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          crossAxisCount: 2,
                          childAspectRatio: 0.65),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        ProductData productData = ProductData.fromDocument(
                            snapshot.data.documents[index]);
                        productData.category = this.snapshot.documentID;
                        return ProductTile('grid', productData);
                      },
                    ),
                    ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        ProductData productData = ProductData.fromDocument(
                            snapshot.data.documents[index]);
                        productData.category = this.snapshot.documentID;
                        return ProductTile('grid', productData);
                      },
                    )
                  ]);
                }
              },
            )));
  }
}
