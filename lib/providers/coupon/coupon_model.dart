import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:stwebclientcopyver2/domains/coupon/coupon.dart';
import 'package:stwebclientcopyver2/repositories/coupon/coupon_repository.dart';

class CouponModel with ChangeNotifier {

  CouponRepository _couponRepository;

  List<Coupon> coupons = List();
  Coupon searchCoupon;

  bool isCouponsFetching = false;
  bool isCouponsSearching = false;

  CouponModel() {
    _couponRepository = Injector.appInstance.getDependency<CouponRepository>();
  }

  List<Coupon> getCoupon() {
    List<Coupon> cpList = List();
    if(this.searchCoupon != null) {
      cpList.add(this.searchCoupon);
    }
    cpList.addAll(this.coupons);
    return cpList;
  }

  Future<void> fetchAll() async {
    isCouponsFetching = true;
    try {
      this.coupons = await _couponRepository.findAll();
    } catch (error) {
      print('[Debug] CouponModel.fetch Error - $error');
    }
    this.isCouponsFetching = false;
    notifyListeners();
  }

  Future<bool> fetchOne({
    @required String code
  }) async {
    bool isValidCode = false;
    isCouponsSearching = true;
    try {
      this.searchCoupon = await _couponRepository.findByCode(code: code);
      isValidCode = true;
    } catch (error) {
      print('[Debug] CouponModel.fetchOne Error - $error');
      isValidCode = false;
    }
    this.isCouponsSearching = false;
    notifyListeners();
    return isValidCode;
  }

  Future<bool> saveByCode({
    @required String code
  }) async {
    bool isValidCode = false;
    isCouponsSearching = true;
    try {
      this.searchCoupon = await _couponRepository.saveByCode(code: code);
      isValidCode = true;
    } catch (error) {
      print('[Debug] CouponModel.saveByCode Error - $error');
      isValidCode = false;
    }
    this.isCouponsSearching = false;
    notifyListeners();
    return isValidCode;
  }

  void clear({bool notify = false}) {
    coupons.clear();
    searchCoupon = null;

    if(notify) {
      notifyListeners();
    }
  }
}