import 'package:flutter/cupertino.dart';
import 'package:stwebclientcopyver2/domains/sort/sort_type.dart';

class HomeSortModel with ChangeNotifier {
  SortType sortType = SortType.SORT_BY_RECOMMEND_DESC;

  void changeSortType(SortType sortType, {bool notify = false}) {
    this.sortType = sortType;
    if(notify) {
      notifyListeners();
    }
  }
}