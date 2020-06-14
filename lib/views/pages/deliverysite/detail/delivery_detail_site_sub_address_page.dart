import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:injector/injector.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/_bases/initalizer/initializer.dart';
import 'package:stwebclientcopyver2/_bases/key/shared_preference_key.dart' as s;
import 'package:stwebclientcopyver2/domains/deliverysite/delivery_site.dart';
import 'package:stwebclientcopyver2/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:stwebclientcopyver2/views/pages/home/home_page.dart';
import 'package:stwebclientcopyver2/views/widgets/deliverysite/detail/delivery_detail_bottom_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/deliverysite/detail/delivery_detail_site_app_bar.dart';

class DeliveryDetailSiteSubAddressPage extends StatefulWidget {

  final DeliverySite deliverySite;
  final DeliveryDetailSite detailSite;

  DeliveryDetailSiteSubAddressPage(this.deliverySite, this.detailSite);

  @override
  _DeliveryDetailSiteSubAddressPageState createState() => _DeliveryDetailSiteSubAddressPageState();
}

class _DeliveryDetailSiteSubAddressPageState extends State<DeliveryDetailSiteSubAddressPage> {

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliverySiteModel>(
        builder: (_, model, __) {
          return ModalProgressHUD(
            inAsyncCall: model.isChanging,
            child: Scaffold(
              appBar: DeliveryDetailSiteAppBar(titleText: '${widget.deliverySite.name} ${widget.detailSite.name}'),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      child: TextField(
                        controller: textEditingController,
                        style: TextStyle(fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        cursorColor: subTextColor,
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: '상세주소를 입력해주세요.',
                        ),
                      ),
                    ),
                    Consumer<DeliveryDetailSiteModel>(
                      builder: (_, detailModel, __) {
                        return  DeliveryDetailBottomBar(
                          centerText: '적용',
                          isActive: !model.isChanging,
                          onSelected: () => _change(
                              dIdx: widget.detailSite.idxDeliverySite,
                              ddIdx: widget.detailSite.idx,
                              subAddr: textEditingController.text
                          ),
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

  void _change({int dIdx, int ddIdx, String subAddr}) async {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    try {
      deliverySiteModel.changeIsChanging(true);

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt(s.idxDeliverySite, dIdx);
      pref.setInt(s.idxDeliveryDetailSite, ddIdx);
      pref.setString(s.deliverySiteSubAddress, subAddr);

      Initializer _initializer = Injector.appInstance.getDependency<Initializer>();
      await _initializer.initializeModelData(context: context);

      Get.offAll(HomePage(), transition: Transition.cupertino);

      // toast 메시지
      Fluttertoast.showToast(
          msg: "적용완료",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: titleFontSize
      );
    } finally {
      deliverySiteModel.changeIsChanging(false);
    }
  }
}
