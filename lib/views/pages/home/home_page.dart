import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stwebclientcopyver2/_bases/key/pmg_key.dart';
import 'package:stwebclientcopyver2/domains/sort/sort_type.dart';
import 'package:stwebclientcopyver2/domains/tab/tab_menu.dart';
import 'package:stwebclientcopyver2/providers/advertisement/advertisement_model.dart';
import 'package:stwebclientcopyver2/providers/cart/cart_model.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';
import 'package:stwebclientcopyver2/providers/order/time/order_time_model.dart';
import 'package:stwebclientcopyver2/providers/payment/payment_model.dart';
import 'package:stwebclientcopyver2/providers/sort/home_sort_model.dart';
import 'package:stwebclientcopyver2/providers/store/store_summary_model.dart';
import 'package:stwebclientcopyver2/providers/tab/tab_model.dart';
import 'package:stwebclientcopyver2/views/pages/deliverysite/delivery_site_page.dart';
import 'package:stwebclientcopyver2/views/widgets/_bases/base_app_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/home/advertisement/home_advertisement_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/home/contents/home_contents_bar_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/home/contents/home_contents_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/home/navigation/home_navigation_right_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/store/slide/store_slide_floating_collapsed_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/store/slide/store_slide_floating_panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  AppLifecycleState _notification = AppLifecycleState.detached;
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();
  final PanelController _panelController = PanelController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isPanelShown = false;

  StoreSummaryModel storeSummaryModel;
  int dIdx;
  int oIdx;
  DateTime oDate;
  SortType sortType;

  StreamController _streamController;
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    storeSummaryModel = Provider.of<StoreSummaryModel>(context, listen: false);
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);

    _init();
    _streamController = StreamController()
      ..addStream(Stream.periodic(
          Duration(seconds: 20), (_) {
            if(isAbleToFetch()) {
              // print('dIdx : ${deliverySiteModel.userDeliverySite?.idx} / oIdx : ${orderTimeModel.userOrderTime?.idx} / oDate : ${orderTimeModel.userOrderDate}');
              storeSummaryModel.fetchQuantityOrderable(
                  dIdx: deliverySiteModel.userDeliverySite?.idx,
                  oIdx: orderTimeModel.userOrderTime?.idx,
                  oDate: orderTimeModel.userOrderDate
              );
            }
          }
      ));
    _streamSubscription = _streamController.stream.listen(storeSummaryModel.setQuantityOrderable);
  }

  bool isAbleToFetch() {
    bool isCurrent = ModalRoute.of(context).isCurrent;
    bool isValidAppLifecycleState = _notification == AppLifecycleState.detached || _notification == AppLifecycleState.resumed;
    // print('isCurrent : $isCurrent / isValidAppLifecycleState : $isValidAppLifecycleState');
    return isCurrent && isValidAppLifecycleState;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() { _notification = state; });
  }

  @override
  void deactivate() {
    super.deactivate();
    if(ModalRoute.of(context).isCurrent && Provider.of<TabModel>(context).tab == TabMenu.home) {
      _streamSubscription.resume();
    } else {
      _streamSubscription.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if(_streamController.isClosed) {
      _streamController.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (_, model, child) {
        bool isShowCart = (model.cart?.items?.length ?? 0) != 0;
        return WillPopScope(
          onWillPop: () async {
            if(_panelController.isPanelOpen) {
              _panelController.close();
            }
            return Future.value(false);
          },
          child: InnerDrawer(
            key: _innerDrawerKey,
            onTapClose: true,
            swipe: false,
            offset: IDOffset.only(right: 0.5, left: 0.5),
            proportionalChildArea : true,
            borderRadius: 0,
            rightAnimationType: InnerDrawerAnimation.static,
            backgroundDecoration: BoxDecoration(color: Colors.white ),
            rightChild: HomeNavigationRightWidget(innerDrawerKey: _innerDrawerKey),
            scaffold: Scaffold(
              //bottomNavigationBar: TabSelector(),
              body: Stack(
                children: <Widget>[
                  Scaffold(
                    appBar: BaseAppBar(
                      onTitleTap: _onTitleTap,
                      onNavigationTap: _onNavigationTap
                    ),
                    body: _body(isShowCart: isShowCart),
                  ),
                  isShowCart
                  ? SafeArea(
                    child: SlidingUpPanel(
                      controller: _panelController,
                      minHeight: 80.0,
                      maxHeight: 550.0,
                      backdropEnabled: true,
                      renderPanelSheet: false,
                      onPanelOpened: () => _onCartOpen(model),
                      onPanelClosed: () => _onCartClose(model),
                      panel: StoreSlideFloatingPanelWidget(
                        onSaveOrder: _onSaveOrder,
                      ),
                      collapsed: StoreSlideFloatingCollapsedWidget(
                        onSelected: () => _panelController.open(),
                      ),
                    ),
                  )
                  : Container()
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void _onTitleTap() {
    Get.to(DeliverySitePage(), transition: Transition.cupertino, duration: Duration.zero);
  }

  void _onNavigationTap() {
    _innerDrawerKey.currentState.open(direction: InnerDrawerDirection.end);
  }

  void _onSaveOrder() async {
    await _panelController.close();
  }

  Widget _body({bool isShowCart = false}) {
    return SafeArea(
      child: CustomScrollView(
        key: PmgKeys.deliveryPage,
        slivers: <Widget>[
          HomeAdvertisementWidget(),
          HomeContentsBarWidget(
            onChangedTime: _onChangedTime,
            onChangedSort: _onChangedSort,
          ),
          HomeContentsWidget(),
          SliverToBoxAdapter(
            child: Container(height: isShowCart ? 55.0 : 0.0),
          )
        ],
      )
    );
  }

  void _onCartOpen(CartModel cartModel) {
    if(isPanelShown) return;
    isPanelShown = true;
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);

    cartModel.updateOrderableStore(
        dIdx: deliverySiteModel.userDeliverySite?.idx,
        oIdx: orderTimeModel.userOrderTime?.idx,
        oDate: orderTimeModel.userOrderDate
    );
  }

  void _onCartClose(CartModel cartModel) {
    isPanelShown = false;
    cartModel.changeIsUpdatedOrderableStore(false);
  }

  void _onChangedTime() {
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _onChangedSort() {
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _onRefresh() async{
    _refreshController.loadComplete();
    _init();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      await storeSummaryModel.fetch(
        dIdx: dIdx,
        oIdx: oIdx,
        oDate: oDate,
        sortType: sortType
      );
      _refreshController.loadComplete();
    }
  }

  void _init() async {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    AdvertisementModel advertisementModel = Provider.of<AdvertisementModel>(context, listen: false);
    HomeSortModel homeSortModel = Provider.of<HomeSortModel>(context, listen: false);

    // index
    dIdx = deliverySiteModel.userDeliverySite?.idx;
    oIdx = orderTimeModel.userOrderTime?.idx;
    oDate = orderTimeModel.userOrderDate;
    sortType = homeSortModel.sortType;

    // store summary fetch
    storeSummaryModel.clear();
    await storeSummaryModel.fetch(
      isForceUpdate: true,
      dIdx: dIdx,
      oIdx: oIdx,
      oDate: oDate,
      sortType: sortType
    );

    // SmartRefresher 상태 초기화
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    }

    // advertisement fetch
    advertisementModel
    ..clear()
    ..fetch(dIdx: dIdx);
  }

}
