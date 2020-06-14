import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';

class SignAppBar extends AppBar {
  SignAppBar(context, {Color backgroundColor = backgroundColor, Color backButtonColor = Colors.black, bool enableBackButton = true, String centerTitle}) : super(
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: true,
    centerTitle: centerTitle != null,
    title: centerTitle == null ? null : Text(centerTitle, style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)),
    leading: enableBackButton
      ? IconButton(
        icon: Icon(Icons.close, color: backButtonColor),
        onPressed:() => Get.back(),
      )
      : Container(),
    elevation: 0.0,
  );
}
