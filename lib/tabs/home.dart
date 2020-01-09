import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  Widget _buildBackground() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: const [Colors.red, Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
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
            )
          ],
        )
      ],
    );
  }
}
