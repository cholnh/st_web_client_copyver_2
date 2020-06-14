import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';

class BaseAppBar extends AppBar {
  final Function onTitleTap;
  final Function onNavigationTap;

  BaseAppBar({
    this.onTitleTap, this.onNavigationTap
  }) : super(
    centerTitle: false,
    automaticallyImplyLeading: false,
    elevation: 0.3,
    title :InkWell(
      child: Consumer<DeliverySiteModel>(
        builder: (_, model, __) {
          return Row(
            children: <Widget>[
              Text('${model?.userDeliverySite?.name ?? ''}', style: TextStyle(fontSize: appBarFontSize, color: Colors.black)),
              const Icon(Icons.arrow_drop_down, color: primaryColor)
            ],
          );
        },
      ),
      onTap: onTitleTap,
    ),
    actions: <Widget>[
      GestureDetector(
        onTap: onNavigationTap,
        child: Material(
          child: Row(
            children: <Widget>[
              Icon(Icons.menu, color: subTextColor),
              Padding(padding: const EdgeInsets.only(right: 11.0))
            ],
          ),
        ),
      )
    ]
  );
}
