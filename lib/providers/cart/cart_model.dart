import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:stwebclientcopyver2/domains/cart/cart.dart';
import 'package:stwebclientcopyver2/domains/cart/item/cart_item.dart';
import 'package:stwebclientcopyver2/domains/coupon/coupon.dart';
import 'package:stwebclientcopyver2/domains/order/time/order_time.dart';
import 'package:stwebclientcopyver2/domains/product/product.dart';
import 'package:stwebclientcopyver2/domains/product/sub/product_sub.dart';
import 'package:stwebclientcopyver2/domains/promotion/promotion.dart';
import 'package:stwebclientcopyver2/domains/store/store.dart';
import 'package:stwebclientcopyver2/domains/store/store_quantity_orderable.dart';
import 'package:stwebclientcopyver2/repositories/store/store_repository.dart';

class CartModel with ChangeNotifier {

  StoreRepository _storeRepository;

  Cart cart = Cart();

  bool isUpdatedOrderableStore = false;
  bool isAllOrderable = true;

  int usingPoint = 0;
  Coupon usingCouponCode;
  List<Coupon> usingCoupons = List();
  List<Promotion> usingPromotions = List();

  CartModel() {
    _storeRepository = Injector.appInstance.getDependency<StoreRepository>();
  }

  List<Coupon> getUsingCoupons() {
    List<Coupon> cpList = List();
    if(this.usingCouponCode != null) {
      cpList.add(this.usingCouponCode);
    }
    cpList.addAll(this.usingCoupons);
    return cpList;
  }

  void cancelCoupon(Coupon coupon, {bool notify = false}) {
    if(this.usingCouponCode != null && this.usingCouponCode.idx == coupon.idx) {
      this.usingCouponCode = null;
      if(notify) {
        notifyListeners();
      }
      return;
    }
    for(Coupon usingCoupon in this.usingCoupons) {
      if(usingCoupon.idx == coupon.idx) {
        this.usingCoupons.remove(usingCoupon);
        if(notify) {
          notifyListeners();
        }
        return;
      }
    }
  }

  void addCoupon(Coupon coupon) {
    usingCoupons.clear(); // 중복방지 (기획이 미완성이라 일단 중복방지로 막아둠)
    usingCoupons.add(coupon);
  }

  int discountPriceUsingCoupons() {
    int discountPrice = 0;
    getUsingCoupons().forEach((usingCoupon) => discountPrice += usingCoupon.discountCost);
    return discountPrice;
  }

  bool isSameOrderDateTime({
    @required DateTime orderDate,
    @required OrderTime orderTime
  }) {
    bool isSameDate =
      cart.orderDate.year == orderDate.year &&
      cart.orderDate.month == orderDate.month &&
      cart.orderDate.day == orderDate.day;
    bool isSameTime = cart.orderTime.idx == orderTime.idx;
    return isSameDate && isSameTime;
  }

  void addItem({
    @required Store store,
    @required Product product,
    @required int quantity,
    @required List<ProductSub> subs,
    String requirement,
    bool notify = false
  }) {
    this.cart.items.add(CartItem(
        idx: _generateIdx(),
        store: store,
        product: product,
        quantity: quantity,
        subs: subs,
        requirement: requirement
    ));

    if(notify) {
      notifyListeners();
    }
  }

  void clear({bool clearItems = true, bool notify = false}) {
    if(clearItems) {
      cart.clear();
    }
    usingPoint = 0;
    usingCouponCode = null;
    usingCoupons.clear();
    usingPromotions.clear();

    if(notify) {
      notifyListeners();
    }
  }

  void removeItem(CartItem removeItem) {
    this.cart.items.removeWhere((CartItem el) => el.idx == removeItem.idx);
    notifyListeners();
  }

  int _generateIdx() {
    int max = 0;
    this.cart.items?.forEach((item) => max = item.idx > max ? item.idx : max);
    return max + 1;
  }

  int totalPrice() {
    int totalDiscount = 0;
    totalDiscount += usingPoint;
    getUsingCoupons().forEach((usingCoupon)
      => totalDiscount += usingCoupon.isValid() ? usingCoupon.discountCost : 0);
    usingPromotions.forEach((usingPromotion)
      => totalDiscount += usingPromotion.isValid() ? usingPromotion.discountCost : 0);
    int totalPrice = cart.totalPrice() - totalDiscount;
    return totalPrice < 0 ? 0 : totalPrice;
  }

  Future<void> updateOrderableStore({
    @required int dIdx,
    @required int oIdx,
    @required DateTime oDate
  }) async {
    Set<int> idxesStore = idxesStoreInCartItem();
    if(idxesStore.isNotEmpty) {
      List<StoreQuantityOrderable> quantities = [];
      try {
        quantities = await _storeRepository.findQuantityOrderableByIdxes(
            dIdx: dIdx,
            oIdx: oIdx,
            oDate: DateFormat('yyyy-MM-dd').format(oDate),
            sIdxes: idxesStore.toList()
        );
      } catch(error) {
        print('[Debug] CartModel.updateOrderableStore Error - $error');
      }

      this.cart.items.forEach((cartItem) {
        cartItem.quantityOrderable = 0;
        for(StoreQuantityOrderable qo in quantities) {
          if(qo.idx == cartItem.store.idx) {
            cartItem.quantityOrderable = qo.quantityOrderable;
            break;
          }
        }
      });

      this.isAllOrderable = true;
      idxesStore.forEach((idxStore) {
        int totalQuantity = 0;
        List<CartItem> cartItems = cartItemsByIdxStore(idxStore);
        cartItems.forEach((item) => totalQuantity += item.quantity);
        bool isOrderable = (cartItems.first?.quantityOrderable ?? 0) - totalQuantity >= 0;
        if(!isOrderable) {
          this.isAllOrderable = false;
        }
        cartItems.forEach((item) {
          item.isOrderable = isOrderable;
        });
      });

    }
    isUpdatedOrderableStore = true;
    notifyListeners();
  }

  List<CartItem> cartItemsByIdxStore(int idxStore) {
    return this.cart.items.where((item) => item.store.idx == idxStore).toList();
  }

  Set<int> idxesStoreInCartItem() {
    return this.cart.items.map((cartItem) => cartItem.store.idx).toSet();
  }

  void changeIsUpdatedOrderableStore(bool tf) {
    this.isUpdatedOrderableStore = tf;
    notifyListeners();
  }
}