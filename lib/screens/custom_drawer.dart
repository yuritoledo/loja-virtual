import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController _controller;

  CustomDrawer(this._controller);

  Widget _buildGradient() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: const [
      Color.fromARGB(255, 203, 236, 241),
      Colors.white,
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildGradient(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                height: 170,
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text('Flutter\'s\nClothin',
                          style: TextStyle(
                              fontSize: 38, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Olá!',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          GestureDetector(
                            child: Text('Entre ou cadastre-se >',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              DrawerTile('Início', Icons.home, _controller, 0),
              DrawerTile('Produtos', Icons.list, _controller, 1),
              DrawerTile('Loja', Icons.place, _controller, 2),
              DrawerTile(
                  'Meus pedidos', Icons.playlist_add_check, _controller, 3),
            ],
          ),
        ],
      ),
    );
  }
}
