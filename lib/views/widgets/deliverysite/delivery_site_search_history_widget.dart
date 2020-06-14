import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/domains/deliverysite/delivery_site.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';
import 'package:stwebclientcopyver2/views/pages/deliverysite/detail/delivery_detail_site_page.dart';


class DeliverySiteSearchHistoryWidget extends StatefulWidget {

  final bool isFirst;

  DeliverySiteSearchHistoryWidget({this.isFirst});

  @override
  _DeliverySiteSearchHistoryWidgetState createState() => _DeliverySiteSearchHistoryWidgetState();
}

class _DeliverySiteSearchHistoryWidgetState extends State<DeliverySiteSearchHistoryWidget> {

  DeliverySiteModel deliverySiteModel;

  @override
  void initState() {
    super.initState();
    deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    deliverySiteModel.fetch(forceUpdate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<DeliverySiteModel>(
        builder: (_, model, __) {
          if(model.isFetching || model.isSearching) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CupertinoActivityIndicator(),
            );
          }

          List<DeliverySite> deliverySites = model.deliverySites;
          if(deliverySites.length == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text('검색 결과가 없습니다.', style: TextStyle(color: subTextColor, fontSize: 12.0)),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('전체 리스트', style: TextStyle(fontSize: 14.0, color: primaryColor)),
              Padding(padding: const EdgeInsets.only(bottom: 30.0)),
              _items(deliverySites)
            ],
          );
        },
      ),
    );
  }

  Widget _items(List<DeliverySite> deliverySites) {
    return Column(
      children: deliverySites.map((DeliverySite deliverySite) {
        return Column(
          children: <Widget>[
            _item(deliverySite),
            Padding(padding: const EdgeInsets.only(bottom: 8.0)),
            Divider(thickness: 0.5),
            Padding(padding: const EdgeInsets.only(bottom: 8.0)),
          ],
        );
      }).toList(),
    );
  }

  Widget _item(DeliverySite deliverySite) {
    String title = deliverySite.name;
    String subTitle = deliverySite.location;

    return GestureDetector(
      onTap: () {
        Get.to(DeliveryDetailSitePage(deliverySite), transition: Transition.cupertino, duration: Duration.zero);
      },
      child: Material(
        child: Row(
          children: <Widget>[
            Icon(Icons.location_on, color: subTextColor, size: 15.0),
            Padding(padding: const EdgeInsets.only(right: 17.0)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0), overflow: TextOverflow.visible),
                  Padding(padding: const EdgeInsets.only(bottom: 5.0)),
                  Text(subTitle, style: TextStyle(fontSize: 14.0, color: subTextColor), overflow: TextOverflow.visible)
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Color.fromRGBO(0x2e, 0x2e, 0x2e, 0.5))
          ],
        ),
      ),
    );
  }

}
