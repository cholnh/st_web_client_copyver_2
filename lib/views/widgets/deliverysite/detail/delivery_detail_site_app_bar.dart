import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';
import 'package:stwebclientcopyver2/providers/product/product_model.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_model.dart';
import 'package:stwebclientcopyver2/views/pages/product/product_page.dart';
import 'package:stwebclientcopyver2/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class DeliveryDetailSiteAppBar extends AppBar {
  final String titleText;
  DeliveryDetailSiteAppBar({this.titleText}) : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(CupertinoIcons.back, color: Colors.black),
      onPressed:() => Get.back(),
    ),
    centerTitle: true,
    title: Column(
      children: <Widget>[
        Text(
          titleText,
          style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
        ),
      ],
    ),
    elevation: 0.0,
  );
}