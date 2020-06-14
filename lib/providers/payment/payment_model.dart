import 'package:bootpay_api/bootpay_api.dart';
import 'package:bootpay_api/model/extra.dart';
import 'package:bootpay_api/model/item.dart';
import 'package:bootpay_api/model/payload.dart';
import 'package:bootpay_api/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stwebclientcopyver2/_bases/key/shared_preference_key.dart' as s;
import 'package:stwebclientcopyver2/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:stwebclientcopyver2/domains/payment/payment.dart';
import 'package:stwebclientcopyver2/domains/payment/payment_type.dart';
import 'package:stwebclientcopyver2/providers/cart/cart_model.dart';
import 'package:stwebclientcopyver2/providers/order/order_model.dart';
import 'package:stwebclientcopyver2/views/pages/payment/bootpay/bootpay_page.dart';

class PaymentModel with ChangeNotifier {

  Payment payment = Payment();

  bool isReadyPayment() {
    return payment?.paymentType != null;
  }

  Future<void> goBootpayRequest(BuildContext context) async {
    try {
      Payload payload = Payload();

      payload.androidApplicationId = '5cc70f38396fa67747bd0684';
      payload.iosApplicationId = '5cc70f38396fa67747bd0685';

      payload.pg = 'kcp';
      payload.methods = ['card', 'vbank', 'bank', 'phone'];
      payload.name = '싸이버거 외 3건';
      payload.price = 13000.0;
      payload.orderId = DateTime.now().millisecondsSinceEpoch.toString();

      User user = User();
      user.username = '최낙형';
      user.email = 'nteve@pomangam.com';
      user.area = '한국항공대';
      user.phone = "010-1234-4567";

      Extra extra = Extra();
      extra.appScheme = 'bootpayFlutterSample';

      Item item1 = Item();
      item1.itemName = '싸이버거'; // 주문정보에 담길 상품명
      item1.qty = 1; // 해당 상품의 주문 수량
      item1.unique = 'p-1'; // 해당 상품의 고유 키
      item1.price = 3000; // 상품의 가격

      Item item2 = Item();
      item2.itemName = '휠렛버거';
      item2.qty = 2;
      item2.unique = 'p-2';
      item2.price = 10000;
      List<Item> itemList = [item1, item2];

      if(kIsWeb) {
//        bootpayWebRequest(Options(
//          application_id: '5cc70f38396fa67747bd0683',
//          name: '테스트이름',
//          order_id: '123',
//          price: '21300'
//        ));

      } else {
        await BootpayApi.request(
          context,
          payload,
          extra: extra,
          user: user,
          items: itemList,
          onDone: (String json) {
            print('onDone: $json');
            CartModel cartModel = Provider.of<CartModel>(context, listen: false);
            cartModel.clear();
            Get.to(BootPayPage(), transition: Transition.cupertino, duration: Duration.zero);
          },
          onReady: (String json) {
            print('onReady: $json');
          },
          onCancel: (String json) {
            print('onCancel: $json');

            /// 임시로 설정!! (지워야함)
            CartModel cartModel = Provider.of<CartModel>(context, listen: false);
            cartModel.clear();
            Get.to(BootPayPage(), transition: Transition.cupertino, duration: Duration.zero);
            /// 임시로 설정!! (지워야함)

          },
          onError: (String json) {
            print('onError: $json');
          },
        );
      }
    } finally {
      OrderModel orderModel = Provider.of<OrderModel>(context, listen: false);
      orderModel.changeIsSaving(false);
    }
  }

  Future<void> loadPayment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    this.payment
    ..paymentType = pref.getString(s.paymentType) != null ? convertTextToPaymentType(pref.getString(s.paymentType)) : PaymentType.COMMON_CREDIT_CARD
    ..cashReceipt.isIssueCashReceipt = pref.getBool(s.isIssueCashReceipt) ?? false
    ..cashReceipt.cashReceiptNumber = pref.getString(s.cashReceiptNumber)
    ..cashReceipt.cashReceiptType = pref.getString(s.cashReceiptType) != null ? convertTextToCashReceiptType(pref.getString(s.cashReceiptType)) : CashReceiptType.PERSONAL_CARD_NUMBER
    ..isPaymentAgree = pref.getBool(s.isPaymentAgree) ?? false
    ..paymentAgreeDate = pref.getString(s.paymentAgreeDate) != null ? DateTime.parse(pref.getString(s.paymentAgreeDate)) : null;
  }

  Future<void> savePaymentType(
    PaymentType paymentType,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.paymentType, paymentType.toString());
    this.payment.paymentType = paymentType;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> saveIsIssueCashReceipt(
      bool isIssueCashReceipt,
      {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(s.isIssueCashReceipt, isIssueCashReceipt);
    this.payment.cashReceipt.isIssueCashReceipt = isIssueCashReceipt;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> saveCashReceiptNumber(
    String cashReceiptNumber,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.cashReceiptNumber, cashReceiptNumber);
    this.payment.cashReceipt.cashReceiptNumber = cashReceiptNumber;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> saveCashReceiptType(
    CashReceiptType cashReceiptType,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.cashReceiptType, cashReceiptType.toString());
    this.payment.cashReceipt.cashReceiptType = cashReceiptType;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> saveIsPaymentAgree(
    bool isPaymentAgree,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(s.isPaymentAgree, isPaymentAgree);
    this.payment.isPaymentAgree = isPaymentAgree;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> savePaymentAgreeDate(
    DateTime paymentAgreeDate,
    {bool notify = false}
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.paymentAgreeDate, paymentAgreeDate?.toIso8601String());
    this.payment.paymentAgreeDate = paymentAgreeDate;
    if(notify) {
      notifyListeners();
    }
  }
}