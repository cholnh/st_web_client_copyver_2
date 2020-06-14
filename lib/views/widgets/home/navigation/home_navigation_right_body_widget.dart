import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/views/pages/event/event_page.dart';
import 'package:stwebclientcopyver2/views/pages/notice/notice_page.dart';
import 'package:stwebclientcopyver2/views/pages/order_info/order_info_page.dart';

class HomeNavigationRightBodyWidget extends StatelessWidget {

  final double height;

  HomeNavigationRightBodyWidget({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => Get.to(OrderInfoPage(), duration: Duration.zero),
            child: Material(
              color: sideMenuBackgroundColor,
              child: Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          '내 주문',
                          style: TextStyle(fontSize: 14.0, color: backgroundColor)
                      ),
                      Padding(padding: const EdgeInsets.only(right: 7.0)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: FittedBox(
                          child: Text(
                              '1',
                              style: TextStyle(fontSize: 12.0, color: backgroundColor, fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(color: sideMenuDividerColor, height: 0.0, thickness: 0.5),
          GestureDetector(
            onTap: () => Get.to(OrderInfoPage(), duration: Duration.zero),
            child: Material(
              color: sideMenuBackgroundColor,
              child: Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Text(
                      '정기 배송',
                      style: TextStyle(fontSize: 14.0, color: backgroundColor)
                  ),
                ),
              ),
            ),
          ),
          Divider(thickness: 8.0, color: sideMenuDividerColor),
          //Divider(color: sideMenuDividerColor, height: 0.0, thickness: 0.5),
          GestureDetector(
            onTap: () => Get.to(EventPage(), duration: Duration.zero),
            child: Material(
              color: sideMenuBackgroundColor,
              child: Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          '이벤트',
                          style: TextStyle(fontSize: 14.0, color: backgroundColor)
                      ),
                      Padding(padding: const EdgeInsets.only(right: 7.0)),
                      Text(
                          'new',
                          style: TextStyle(fontSize: 11.0, color: primaryColor, fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(color: sideMenuDividerColor, height: 0.0, thickness: 0.5),
          GestureDetector(
            onTap: () => Get.to(NoticePage(), duration: Duration.zero),
            child: Material(
              color: sideMenuBackgroundColor,
              child: Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          '공지사항',
                          style: TextStyle(fontSize: 14.0, color: backgroundColor)
                      ),
                      Padding(padding: const EdgeInsets.only(right: 7.0)),
                      Text(
                          'new',
                          style: TextStyle(fontSize: 11.0, color: primaryColor, fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(color: sideMenuDividerColor, height: 0.0, thickness: 0.5),
          Container(
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      '친구초대',
                      style: TextStyle(fontSize: 14.0, color: backgroundColor)
                  ),
                ],
              ),
            ),
          ),
          Divider(color: sideMenuDividerColor, height: 0.0, thickness: 0.5),
          Container(
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      '문의하기',
                      style: TextStyle(fontSize: 14.0, color: backgroundColor)
                  ),
                ],
              ),
            ),
          ),
          Divider(color: sideMenuDividerColor, height: 0.0, thickness: 0.5),
        ],
      ),
    );
  }
}
