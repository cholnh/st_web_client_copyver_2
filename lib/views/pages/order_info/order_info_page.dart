import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/views/widgets/order_info/order_info_app_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/order_info/order_info_current_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/order_info/order_info_history_widget.dart';

class OrderInfoPage extends StatefulWidget  {

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> with SingleTickerProviderStateMixin {

  bool isFirst;
  TabController tabController;

  void initState() {
    super.initState();
    isFirst = true;
    tabController = new TabController(vsync: this, length: 2);
    tabController.addListener(() {
      if(isFirst && tabController.index == 1) {
        // 주문 내역 tab
        print('주문내역 fetch');
        isFirst = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderInfoAppBar(bottom: TabBar(
        controller: tabController,
        labelColor: Colors.black,
        indicatorColor: primaryColor,
        unselectedLabelColor: subTextColor,
        tabs: [
          Tab(text: '내 주문'),
          Tab(text: '주문 내역',),
        ],
      )),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [
            OrderInfoCurrentWidget(),
            OrderInfoHistoryWidget()
          ]
        )
      ),
    );
  }
}
