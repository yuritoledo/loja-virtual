import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  Widget _buildBackground() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: const [
          Color.fromARGB(255, 132, 30, 112),
          Colors.deepPurple
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildBackground(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0.0,
              snap: true,
              floating: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Novidades!'),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
                future: Firestore.instance
                    .collection('home')
                    .orderBy('pos')
                    .getDocuments(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final list = snapshot.data.documents;
                    return SliverStaggeredGrid.count(
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      crossAxisCount: 2,
                      staggeredTiles: list
                          .map((item) => StaggeredTile.count(
                              item.data['x'], item.data['y']))
                          .toList(),
                      children: list
                          .map((item) => FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: item.data['image'],
                                fit: BoxFit.cover,
                              ))
                          .toList(),
                    );
                  } else {
                    return SliverToBoxAdapter(
                        child: Container(
                      height: 200.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ));
                  }
                })
          ],
        )
      ],
    );
  }
}
