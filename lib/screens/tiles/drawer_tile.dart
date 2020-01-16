import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final PageController controller;
  final int pageIndex;

  DrawerTile(this.text, this.icon, this.controller, this.pageIndex);

  @override
  Widget build(BuildContext context) {
    final Color activeColor = controller.page.toInt() == pageIndex
        ? Theme.of(context).primaryColor
        : Colors.grey[700];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(pageIndex);
        },
        child: Container(
          height: 60,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: activeColor,
                size: 32,
              ),
              SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 16, color: activeColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
