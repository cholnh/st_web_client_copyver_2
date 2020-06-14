import 'package:flutter/foundation.dart';
import 'package:stwebclientcopyver2/domains/tab/tab_menu.dart';

class TabModel with ChangeNotifier {

  TabMenu tab = TabMenu.home;

  change(TabMenu to) {
    tab = to;
    notifyListeners();
  }
}