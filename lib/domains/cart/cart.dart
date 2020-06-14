import 'package:stwebclientcopyver2/domains/cart/item/cart_item.dart';
import 'package:stwebclientcopyver2/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:stwebclientcopyver2/domains/order/item/order_item_request.dart';
import 'package:stwebclientcopyver2/domains/order/time/order_time.dart';

class Cart {

  DateTime orderDate;

  OrderTime orderTime;

  DeliveryDetailSite detail;

  String subAddress;

  List<CartItem> items = List();

  int totalPrice() {
    int total = 0;
    items?.forEach((item) {
      total += item?.totalPrice() ?? 0;
    });
    return total;
  }

  void clear() {
    items.clear();
  }

  List<OrderItemRequest> orderItems() {
    return items.map((item) {
      return OrderItemRequest(
        idxStore: item.store.idx,
        idxProduct: item.product.idx,
        quantity: item.quantity,
        requirement: item.requirement,
        orderItemSubs: item.orderSubItems()
      );
    }).toList();
  }
}