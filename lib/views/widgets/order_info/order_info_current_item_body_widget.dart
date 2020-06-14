import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/views/widgets/order_info/order_info_current_item_body_list_item_widget.dart';

class OrderInfoCurrentItemBodyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                textAlign: TextAlign.left,
                softWrap: true,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '탄현 풍림아파트 14단지 101동 504호', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Text('변경', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: titleFontSize))
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 3.0)),
          Text(
            '오늘 새벽 6시 도착',
            style: TextStyle(fontSize: 14, color: subTextColor)
          ),
          Divider(height: 30.0, thickness: 0.5),
          OrderInfoCurrentItemBodyListItemWidget(),
        ]
      )
    );
  }
}
