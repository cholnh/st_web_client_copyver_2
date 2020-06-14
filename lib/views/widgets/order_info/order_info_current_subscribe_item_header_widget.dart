import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';

class OrderInfoCurrentSubscribeItemHeaderWidget extends StatelessWidget {

  final String title;

  OrderInfoCurrentSubscribeItemHeaderWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0)
              ),
            ),
            child: Text(title, style: TextStyle(fontSize: 13.0, color: backgroundColor))
          )
        ],
      ),
    );
  }
}
