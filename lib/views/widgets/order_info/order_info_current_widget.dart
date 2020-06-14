import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/views/widgets/order_info/order_info_app_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/order_info/order_info_current_bundle_item_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/order_info/order_info_current_subscribe_item_widget.dart';

class OrderInfoCurrentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            OrderInfoCurrentBundleItemWidget(),
            OrderInfoCurrentSubscribeItemWidget()
          ],
        )
    );
  }
}
