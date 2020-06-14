import 'package:get/get.dart';
import 'package:stwebclientcopyver2/views/pages/home/home_page.dart';

final Map<String, GetRoute> routes = {
  '/home': GetRoute(page: HomePage(), transition: Transition.fade),
};