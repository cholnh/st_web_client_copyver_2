import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';

class OrderInfoCurrentItemMembershipWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('정기배송 멤버십', style: TextStyle(fontSize: 16.0)),
              Text('멤버십 연장', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: titleFontSize))
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10.0)),
          Text(
              '내맘대로 반찬3가지 매일매일 멤버십',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)
          ),
          Text(
              '2020년 07월 10일 까지',
              style: TextStyle(fontSize: 12.0, color: subTextColor)
          ),
        ],
      ),
    );
  }
}
