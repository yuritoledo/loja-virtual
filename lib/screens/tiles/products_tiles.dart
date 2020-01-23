import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/product.dart';
import 'package:lojavirtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final ProductData product;

  final String type;

  ProductTile(this.type, this.product);
  @override
  Widget build(BuildContext context) {
    final String formattedPrice =
        'R\$ ${product.price.toStringAsFixed(2).replaceFirst('.', ',')}';
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product)));
      },
      child: Card(
          child: type == 'grid'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(product.title, style: TextStyle(fontSize: 20)),
                          Text(
                            formattedPrice,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Row(children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                      height: 250.0,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(product.title, style: TextStyle(fontSize: 20)),
                        Text(
                          formattedPrice,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  )
                ])),
    );
  }
}
