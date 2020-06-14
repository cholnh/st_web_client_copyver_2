import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';

class OrderInfoCurrentBundleItemHeaderWidget extends StatelessWidget {

  final Color unSelectedColor = Colors.black.withOpacity(0.3);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: unSelectedColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0)
              ),
            ),
            child: Text('주문대기', style: TextStyle(fontSize: 13.0, color: backgroundColor))
          ),
          Icon(Icons.arrow_right, color: unSelectedColor),
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('메뉴준비', style: TextStyle(fontSize: 13.0, color: backgroundColor))
          ),
          Icon(Icons.arrow_right, color: primaryColor),
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: unSelectedColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('배송중', style: TextStyle(fontSize: 13.0, color: backgroundColor))
          ),
          Icon(Icons.arrow_right, color: unSelectedColor),
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: unSelectedColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('배송완료', style: TextStyle(fontSize: 13.0, color: backgroundColor))
          )
        ],
      ),
    );
  }
}
