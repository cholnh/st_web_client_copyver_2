import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/views/widgets/order_info/order_info_current_bundle_item_header_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/order_info/order_info_current_item_body_widget.dart';

class OrderInfoCurrentBundleItemWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          ),
          border: Border.all(
            width: 0.5,
            color: subTextColor,
          )
        ),
        child: Column(
          children: <Widget>[
            OrderInfoCurrentBundleItemHeaderWidget(),
            Divider(color: subTextColor, thickness: 0.5),
            OrderInfoCurrentItemBodyWidget(),
            Container(
              height: 45.0,
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(
                  width: 0.5,
                  color: primaryColor
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                )
              ),
              child: Center(child: Text('주문취소', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold))),
            )
          ],
        ),
      ),
    );
  }
}
