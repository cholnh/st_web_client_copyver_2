import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/providers/coupon/coupon_model.dart';

Future<bool> couponDataInitialize({
  BuildContext context,
  int dIdx
}) async {
  try {
    log('start couponDataInitialize', name: 'couponDataInitialize', time: DateTime.now());

    CouponModel couponModel = Provider.of<CouponModel>(context, listen: false)
    ..clear();
    await couponModel.fetchAll();

    log('success', name: 'couponDataInitialize', time: DateTime.now());
    return true;
  } catch(error) {
    log('fail', name: 'couponDataInitialize', time: DateTime.now(), error: error);
    return false;
  }
}