import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/product.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(title: Text(product.title), centerTitle: true),
      body: ListView(children: <Widget>[
        AspectRatio(
          aspectRatio: 0.9,
          child: Carousel(
            images: product.images.map((i) => NetworkImage(i)).toList(),
            autoplay: false,
            dotBgColor: Colors.transparent,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(product.title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 26)),
              Text('R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                      fontSize: 26)),
            ],
          ),
        )
      ]),
    );
  }
}
