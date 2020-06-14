import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/domains/deliverysite/delivery_site.dart';
import 'package:stwebclientcopyver2/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:stwebclientcopyver2/views/pages/deliverysite/detail/delivery_detail_site_sub_address_page.dart';
import 'package:stwebclientcopyver2/views/widgets/deliverysite/detail/delivery_detail_bottom_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/deliverysite/detail/delivery_detail_site_app_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/deliverysite/detail/delivery_detail_site_items_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/deliverysite/detail/delivery_detail_site_web_map_widget.dart';

class DeliveryDetailSitePage extends StatefulWidget {

  final DeliverySite deliverySite;

  DeliveryDetailSitePage(this.deliverySite);

  @override
  _DeliveryDetailSitePageState createState() => _DeliveryDetailSitePageState();
}

class _DeliveryDetailSitePageState extends State<DeliveryDetailSitePage> {

  GlobalKey<GoogleMapStateBase> googleKey = GlobalKey<GoogleMapStateBase>();
  DeliveryDetailSiteModel detailSiteModel;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    detailSiteModel = Provider.of<DeliveryDetailSiteModel>(context, listen: false);
    await detailSiteModel.fetch(
        dIdx: widget.deliverySite.idx,
        forceUpdate: true
    );
    if(detailSiteModel.deliveryDetailSites.isNotEmpty) {
      DeliveryDetailSite detailSite = detailSiteModel.deliveryDetailSites.first;
      detailSiteModel.changeSelected(detailSite);
      _changeCameraPosition(detailSite.latitude, detailSite.longitude);
      detailSiteModel.deliveryDetailSites.forEach((DeliveryDetailSite detailSite) {
        _makeMarker(detailSite.latitude, detailSite.longitude);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliverySiteModel>(
        builder: (_, model, __) {
          return ModalProgressHUD(
            inAsyncCall: model.isChanging,
            child: Scaffold(
              appBar: DeliveryDetailSiteAppBar(titleText: '${widget.deliverySite.name} 상세위치'),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    DeliveryDetailSiteWebMapWidget(googleKey: googleKey),
                    Expanded(
                      child: SingleChildScrollView(
                        child: DeliveryDetailSiteItemsWidget(googleKey: googleKey, dIdx: widget.deliverySite.idx)
                      )
                    ),
                    Consumer<DeliveryDetailSiteModel>(
                      builder: (_, detailModel, __) {
                        return  DeliveryDetailBottomBar(
                          centerText: '다음',
                          isActive: !model.isChanging,
                          onSelected: () => Get.to(DeliveryDetailSiteSubAddressPage(widget.deliverySite, detailModel.selected), duration: Duration.zero),
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  void _makeMarker(double lat, double lng) {
    GoogleMap.of(googleKey).addMarker(Marker(
      GeoCoord(lat, lng),
    ));
  }

  void _changeCameraPosition(double lat, double lng) async {
    double c = 0.0009;
    GoogleMap.of(googleKey).moveCamera(GeoCoordBounds(
      northeast: GeoCoord(lat+c, lng+c),
      southwest: GeoCoord(lat-c, lng-c),
    ), padding: 0, animated: true);
  }
}
