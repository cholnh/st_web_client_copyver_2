import 'package:flutter/foundation.dart';
import 'package:stwebclientcopyver2/_bases/network/api/api.dart';
import 'package:stwebclientcopyver2/domains/order/order_request.dart';
import 'package:stwebclientcopyver2/domains/order/order_response.dart';

class OrderRepository {

  final Api api; // 서버 연결용
  OrderRepository({this.api});

  Future<OrderResponse> saveOrder({
    @required OrderRequest orderRequest
  }) async => OrderResponse.fromJson((await api.post(
      url: '/orders',
      data: orderRequest.toJson())).data);

  Future<bool> verify({
    @required int oIdx
  }) async => (await api.post(
      url: '/orders/$oIdx/verify')).data;
}