import 'package:stwebclientcopyver2/domains/order/item/sub/order_item_sub_request.dart';
import 'package:stwebclientcopyver2/domains/product/product.dart';
import 'package:stwebclientcopyver2/domains/product/sub/product_sub.dart';
import 'package:stwebclientcopyver2/domains/store/store.dart';

class CartItem {

  int idx;

  Store store;

  Product product;

  int quantity;

  List<ProductSub> subs = List();

  String requirement;

  int quantityOrderable;

  bool isOrderable = true;

  CartItem({
    this.idx, this.store, this.product,
    this.quantity, this.subs, this.requirement
  });

  int totalPrice() {
    int total = 0;
    total += product?.salePrice ?? 0;
    subs?.forEach((sub) {
      total += sub?.salePrice ?? 0;
    });
    return total * quantity;
  }

  List<OrderItemSubRequest> orderSubItems() {
    return subs.map((sub) {
      return OrderItemSubRequest(
        idxProductSub: sub.idx,
        quantity: quantity
      );
    }).toList();
  }
}