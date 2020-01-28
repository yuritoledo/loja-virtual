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

  String selectedSize;

  _ProductScreenState(this.product);

  void _selectSize(String selected) {
    setState(() {
      selectedSize = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(title: Text(product.title), centerTitle: true),
      body: ListView(children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Carousel(
            images: product.images.map((i) => NetworkImage(i)).toList(),
            autoplay: false,
            dotBgColor: Colors.transparent,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(product.title,
                  maxLines: 3,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
              Text('R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                      fontSize: 24)),
              SizedBox(height: 8),
              Text('Tamanhos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              SizedBox(
                  height: 40,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.5,
                        crossAxisCount: 1,
                        mainAxisSpacing: 8),
                    children: product.sizes.map((size) {
                      return GestureDetector(
                        onTap: () => _selectSize(size),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              color: selectedSize == size ? primaryColor : null,
                              border:
                                  Border.all(color: primaryColor, width: 2.0)),
                          child: Text(
                            size,
                            style: TextStyle(
                                color: selectedSize == size
                                    ? Colors.white
                                    : primaryColor),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
              SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: RaisedButton(
                  color: primaryColor,
                  textColor: Colors.white,
                  child: Text(
                    'Adicionar ao carrinho',
                    style: TextStyle(fontSize: 22),
                  ),
                  onPressed: selectedSize == null ? null : () {},
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Descrição',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Text(
                product.description,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
