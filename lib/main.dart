import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/_bases/di/injector_register.dart';
import 'package:stwebclientcopyver2/_bases/i18n/i18n.dart';
import 'package:stwebclientcopyver2/_bases/router/app_router_v.dart';
import 'package:stwebclientcopyver2/providers/advertisement/advertisement_model.dart';
import 'package:stwebclientcopyver2/providers/cart/cart_model.dart';
import 'package:stwebclientcopyver2/providers/coupon/coupon_model.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:stwebclientcopyver2/providers/event/event_model.dart';
import 'package:stwebclientcopyver2/providers/notice/notice_model.dart';
import 'package:stwebclientcopyver2/providers/order/order_model.dart';
import 'package:stwebclientcopyver2/providers/order/time/order_time_model.dart';
import 'package:stwebclientcopyver2/providers/payment/payment_model.dart';
import 'package:stwebclientcopyver2/providers/point/point_model.dart';
import 'package:stwebclientcopyver2/providers/policy/policy_model.dart';
import 'package:stwebclientcopyver2/providers/product/product_model.dart';
import 'package:stwebclientcopyver2/providers/product/product_summary_model.dart';
import 'package:stwebclientcopyver2/providers/product/product_view_model.dart';
import 'package:stwebclientcopyver2/providers/product/sub/product_sub_category_model.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_model.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_up_model.dart';
import 'package:stwebclientcopyver2/providers/sort/home_sort_model.dart';
import 'package:stwebclientcopyver2/providers/store/store_model.dart';
import 'package:stwebclientcopyver2/providers/store/store_product_category_model.dart';
import 'package:stwebclientcopyver2/providers/store/store_summary_model.dart';
import 'package:stwebclientcopyver2/providers/store/store_view_model.dart';
import 'package:stwebclientcopyver2/providers/tab/tab_model.dart';
import 'package:stwebclientcopyver2/views/pages/_bases/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  GoogleMap.init('AIzaSyCfgL80z55BPeCaCQSfiyabWK_J8YJkd5s');
  WidgetsFlutterBinding.ensureInitialized();
  InjectorRegister.register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final AppRouter router = Injector.appInstance.getDependency<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => SignUpModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => SignInModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => DeliverySiteModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => DeliveryDetailSiteModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => OrderTimeModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => StoreSummaryModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => StoreModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => StoreProductCategoryModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => ProductModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => ProductSummaryModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => ProductSubCategoryModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => AdvertisementModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => CartModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => PaymentModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => PolicyModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => PointModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => ProductViewModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => StoreViewModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => HomeSortModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => CouponModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => OrderModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => NoticeModel(), lazy: true),
        ChangeNotifierProvider(create: (_) => EventModel(), lazy: true),

      ],
      child: GetMaterialApp(
        title: '${Messages.appName}',
        theme: ThemeData(
          primarySwatch: primarySwatch,
          primaryColor: primaryColor,
          accentColor: primaryColor,
          canvasColor: backgroundColor,
          appBarTheme: AppBarTheme(
            color: backgroundColor
          ),
        ),
        darkTheme: ThemeData.dark(),
        home: SplashPage(),
        localizationsDelegates: [
          AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,

          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        supportedLocales: [Locale('ko'), Locale('en')],
        namedRoutes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
