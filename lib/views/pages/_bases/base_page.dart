import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/domains/tab/tab_menu.dart';
import 'package:stwebclientcopyver2/providers/tab/tab_model.dart';
import 'package:stwebclientcopyver2/views/pages/home/home_page.dart';
import 'package:stwebclientcopyver2/views/pages/more/more_page.dart';
import 'package:stwebclientcopyver2/views/pages/order_info/order_info_page.dart';
import 'package:stwebclientcopyver2/views/pages/recommend/recommend_page.dart';
import 'package:provider/provider.dart';

class BasePage extends StatelessWidget {
  BasePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabModel tabModel = Provider.of<TabModel>(context);
    return _selectedPage(tabModel.tab);
  }

  _selectedPage(TabMenu tab) {
    switch(tab) {
      case TabMenu.recommend:
        return RecommendPage();
      case TabMenu.orderInfo:
        return OrderInfoPage();
      case TabMenu.more:
        return MorePage();
      default:
        return HomePage();
    }
  }
}
