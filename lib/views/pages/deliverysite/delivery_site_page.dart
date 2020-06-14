import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';
import 'package:stwebclientcopyver2/views/pages/deliverysite/delivery_site_page_type.dart';
import 'package:stwebclientcopyver2/views/widgets/deliverysite/delivery_site_app_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/deliverysite/delivery_site_search_history_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/deliverysite/delivery_site_search_widget.dart';

class DeliverySitePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DeliverySitePageType deliverySitePageType = Get.arguments;
    bool isFirst = deliverySitePageType == DeliverySitePageType.FROM_INIT;
    return Consumer<DeliverySiteModel>(
      builder: (_, model, __) {
        return ModalProgressHUD(
          inAsyncCall: model.isChanging,
          child: Scaffold(
            appBar: DeliverySiteAppBar(isFirst: isFirst),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(top: 10.0)),
                    DeliverySiteSearchWidget(),
                    Divider(thickness: 8.0, color: Colors.black.withOpacity(0.03)),
                    DeliverySiteSearchHistoryWidget(isFirst: isFirst)
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
