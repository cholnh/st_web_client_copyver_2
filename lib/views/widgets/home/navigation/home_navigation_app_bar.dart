import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';

class HomeNavigationAppBar extends AppBar {
  final Function onCloseTap;

  HomeNavigationAppBar({
    this.onCloseTap
  }) : super(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      actions: <Widget>[
        GestureDetector(
          onTap: onCloseTap,
          child: Material(
            child: Row(
              children: <Widget>[
                Icon(Icons.close, color: subTextColor),
                Padding(padding: const EdgeInsets.only(right: 11.0))
              ],
            ),
          ),
        )
      ]
  );
}
