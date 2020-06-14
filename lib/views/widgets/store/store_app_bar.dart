import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_model.dart';
import 'package:stwebclientcopyver2/providers/store/store_model.dart';
import 'package:stwebclientcopyver2/views/pages/store/store_page.dart';
import 'package:stwebclientcopyver2/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class StoreAppBar extends AppBar {
  StoreAppBar(context) : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(CupertinoIcons.back, color: Colors.black),
      onPressed:() => Get.back()// Navigator.pop(context, false),
    ),
    centerTitle: true,
    title: Consumer<StoreModel>(
      builder: (_, model, child) {
        return Text(
            '${model?.summary?.name ?? ''}',
            style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
        );
      },
    ),
    actions: <Widget>[
      Consumer<StoreModel>(
        builder: (_, model, child) {
          return IconButton(
            icon: model?.store?.isLike != null &&  model.store.isLike
                ? const Icon(Icons.favorite, color: primaryColor)
                : const Icon(Icons.favorite_border, color: primaryColor),
            onPressed: () => _onPressed(context: context, model: model),
          );
        },
      )
    ],
    elevation: 0.0,
  );
}

void _onPressed({BuildContext context, StoreModel model}) {
  if(model.store == null) return;

  bool isSignIn = Provider.of<SignInModel>(context, listen: false).isSignIn();
  if(isSignIn) {
    model.likeToggle(
        dIdx: model.store?.idxDeliverySite,
        sIdx: model.store?.idx
    );
  } else {
    showSignModal(context: context, returnPage: StorePage(sIdx:  model.store?.idx), predicateUrl: List()..add('/homepage'));
  }
}