import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/_bases/util/string_utils.dart';
import 'package:stwebclientcopyver2/domains/coupon/coupon.dart';
import 'package:stwebclientcopyver2/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:stwebclientcopyver2/domains/payment/payment_type.dart';
import 'package:stwebclientcopyver2/providers/cart/cart_model.dart';
import 'package:stwebclientcopyver2/providers/payment/payment_model.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_model.dart';
import 'package:stwebclientcopyver2/views/pages/home/home_page.dart';
import 'package:stwebclientcopyver2/views/pages/payment/agreement/payment_agreement_page.dart';
import 'package:stwebclientcopyver2/views/pages/payment/cash_receipt/payment_cash_receipt_page.dart';
import 'package:stwebclientcopyver2/views/pages/payment/coupon/payment_coupon_page.dart';
import 'package:stwebclientcopyver2/views/pages/payment/method/payment_method_page.dart';
import 'package:stwebclientcopyver2/views/pages/payment/payment_page_type.dart';
import 'package:stwebclientcopyver2/views/pages/payment/point/payment_point_page.dart';
import 'package:stwebclientcopyver2/views/pages/payment/point/payment_point_page_type.dart';
import 'package:stwebclientcopyver2/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:stwebclientcopyver2/views/widgets/payment/payment_item_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/sign/sign_modal.dart';
import 'package:stwebclientcopyver2/views/widgets/user_info/user_info_app_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/user_info/user_info_category_title_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/user_info/user_info_profile_widget.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CartModel cartModel = Provider.of<CartModel>(context);
    SignInModel signInModel = Provider.of<SignInModel>(context);
    bool isSignIn = signInModel.isSignIn();
    List<Coupon> coupons = cartModel.getUsingCoupons();

    return Scaffold(
      appBar: UserInfoAppBar(),
      body: Consumer<PaymentModel>(
        builder: (_, paymentModel, __) {
          PaymentType paymentType = paymentModel.payment?.paymentType;
          CashReceiptType cashReceiptType = paymentModel.payment?.cashReceipt?.cashReceiptType;
          String cashReceiptNumber = paymentModel.payment?.cashReceipt?.cashReceiptNumber ?? '';
          bool isIssueCashReceipt = paymentModel.payment?.cashReceipt?.isIssueCashReceipt == null ? false : paymentModel.payment.cashReceipt.isIssueCashReceipt;
          bool isPaymentAgree = paymentModel.payment?.isPaymentAgree == null ? false : paymentModel.payment.isPaymentAgree;
          return CustomScrollView(
            slivers: <Widget>[
              UserInfoProfileWidget(),
              UserInfoCategoryTitleWidget(title: '계정'),
              PaymentItemWidget(
                title: '닉네임 변경',
                onSelected: () => Get.to(PaymentMethodPage(), transition: Transition.cupertino, duration: Duration.zero),
              ),
              PaymentItemWidget(
                title: '회원 탈퇴',
                onSelected: () {
                  DialogUtils.dialogYesOrNo(context, '영구 탈퇴 하시겠습니까?', onConfirm: (dialogContext) async {
                    DialogUtils.dialog(context, '고객센터로 문의하시기 바랍니다.');
                  });
                },
              ),
              PaymentItemWidget(
                title: '로그아웃',
                onSelected: () {
                  DialogUtils.dialogYesOrNo(context, '로그아웃 하시겠습니까?', onConfirm: (dialogContext) async {
                    await signInModel.signOut();
                    Get.offAll(HomePage(), transition: Transition.fade);
                  });
                },
              ),
              UserInfoCategoryTitleWidget(title: '결제'),
              PaymentItemWidget(
                title: '결제수단',
                subTitle: convertPaymentTypeToText(paymentType),
                onSelected: () => Get.to(PaymentMethodPage(), transition: Transition.cupertino, duration: Duration.zero),
              ),
              PaymentItemWidget(
                title: '포인트',
                subTitle: isSignIn
                    ? cartModel.usingPoint > 0
                    ? '${StringUtils.comma(cartModel.usingPoint)}포인트 사용'
                    : (signInModel.userInfo?.userPoint ?? 0) > 0
                    ? '${StringUtils.comma(signInModel.userInfo?.userPoint ?? 0)}포인트 사용가능'
                    : '포인트 없음'
                    : '로그인이 필요합니다',
                onSelected: isSignIn
                    ? () => Get.to(PaymentPointPage(), arguments: PaymentPointPageType.FROM_SETTING, transition: Transition.cupertino, duration: Duration.zero)
                    : () => showSignModal(context: context, returnPage: UserInfoPage(), arguments: PaymentPageType.FROM_SETTING, predicateUrl: List()..add('/homepage')),
                //isActive: isSignIn,
              ),
              PaymentItemWidget(
                title: '할인쿠폰 등록',
                subTitle: coupons.length > 0
                    ? _couponTitle(coupons)
                    : '쿠폰코드를 입력 또는 선택해 주세요',
                onSelected: () => Get.to(PaymentCouponPage(), transition: Transition.cupertino, duration: Duration.zero),
              ),
              PaymentItemWidget(
                title: '현금영수증',
                subTitle: isIssueCashReceipt ? '${convertCashReceiptTypeToShortText(cashReceiptType)} $cashReceiptNumber' : '미발급',
                onSelected: () => Get.to(PaymentCashReceiptPage(), transition: Transition.cupertino, duration: Duration.zero),
              ),
              PaymentItemWidget(
                title: '결제에 관한 동의',
                subTitle: !isPaymentAgree || paymentModel.payment?.paymentAgreeDate == null ? '결제를 위해 동의가 필요합니다.' : '${_agreementDate(paymentModel.payment.paymentAgreeDate)} 동의 완료',
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                      isPaymentAgree ? '동의' : '동의 안 함',
                      style: TextStyle(color: primaryColor, fontSize: 14.0, fontWeight: FontWeight.bold)),
                ),
                onSelected: () => Get.to(PaymentAgreementPage(), transition: Transition.cupertino, duration: Duration.zero),
              )
            ],
          );
        },
      ),
    );
  }

  String _agreementDate(DateTime dt) {
    return DateFormat('yyyy년 MM월 dd일').format(dt);
  }

  String _couponTitle(List<Coupon> coupons) {
    String title = '';
    for(int i=0; i<coupons.length; i++) {
      title += '${coupons[i].title}(${StringUtils.comma(coupons[i].discountCost)}원)';
      if(i != coupons.length - 1) {
        title += ', ';
      }
    }
    return title;
  }
}
