import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:stwebclientcopyver2/providers/cart/cart_model.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:stwebclientcopyver2/providers/order/time/order_time_model.dart';
import 'package:provider/provider.dart';

Future<bool> cartDataInitialize({
  BuildContext context,
  String subAddr
}) async {
  try {
    log('start cartData', name: 'cartDataInitialize', time: DateTime.now());

    // 카트 초기화
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    DeliveryDetailSiteModel detailSiteModel = Provider.of<DeliveryDetailSiteModel>(context, listen: false);
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);
    cartModel.clear(clearItems: true);
    cartModel.cart
    ..orderDate = orderTimeModel.userOrderDate
    ..orderTime = orderTimeModel.userOrderTime
    ..detail = detailSiteModel.userDeliveryDetailSite
    ..subAddress = subAddr;

    log('success', name: 'cartDataInitialize', time: DateTime.now());
    return true;
  } catch(error) {
    log('fail', name: 'cartDataInitialize', time: DateTime.now(), error: error);
    return false;
  }
}