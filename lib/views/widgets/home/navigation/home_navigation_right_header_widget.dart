import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/coupon/coupon_model.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_model.dart';

class HomeNavigationRightHeaderWidget extends StatelessWidget {

  final double width;
  final Function onTap;

  HomeNavigationRightHeaderWidget({this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: sideMenuBackgroundColor,
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Consumer<SignInModel>(
            builder: (_, userModel, __) {
              if(userModel.isSignIn()) {
                return Row(
                  children: <Widget>[
                    RotationTransition(
                      turns: AlwaysStoppedAnimation(332 / 360),
                      child: Image(
                          image: const AssetImage('assets/logo_transparant.png'),
                          width: 50,
                          height: 50
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(right: 13.0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('${userModel.userInfo.userPointRank.title},',  style: TextStyle(color: backgroundColor, fontSize: 13.0)),
                            Text(' ${userModel.userInfo.nickname}',  style: TextStyle(color: backgroundColor, fontSize: 16.0, fontWeight: FontWeight.bold)),
                            Text(' 님',  style: TextStyle(color: backgroundColor, fontSize: 13.0)),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(bottom: 5.0)),
                        Consumer<CouponModel>(
                          builder: (_, couponModel, __) {
                            return Row(
                              children: <Widget>[
                                Text('포인트 ${userModel.userInfo.userPoint}P',  style: TextStyle(color: backgroundColor, fontSize: 12.0)),
                                couponModel.coupons.isNotEmpty
                                  ? Text('  /  쿠폰 ${couponModel.coupons.length}개',  style: TextStyle(color: backgroundColor, fontSize: 12.0))
                                  : Container()
                              ],
                            );
                          }
                        ),
                      ],
                    ),
                    Expanded(child: Icon(Icons.chevron_right, color: backgroundColor, size: 16.0))
                  ],
                );
              } else {
                return Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RotationTransition(
                          turns: AlwaysStoppedAnimation(332 / 360),
                          child: Image(
                              image: const AssetImage('assets/logo_transparant.png'),
                              width: 25,
                              height: 25
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(right: 8.0)),
                        Text('로그인', style: TextStyle(color: backgroundColor, fontSize: 14.0, fontWeight: FontWeight.w600)),
                      ],
                    )
                );
              }
            }
          ),
        ),
      ),
    );
  }


}
