import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/providers/product/product_model.dart';

class UserInfoAppBar extends AppBar {
  UserInfoAppBar() : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(Icons.close, color: Colors.black),
      onPressed:() => Get.back(),
    ),
    centerTitle: true,
    title: Consumer<ProductModel>(
      builder: (_, model, child) {
        return Column(
          children: <Widget>[
            Text(
              '내 정보',
              style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
            ),
          ],
        );
      },
    ),
    elevation: 0.0,
  );
}