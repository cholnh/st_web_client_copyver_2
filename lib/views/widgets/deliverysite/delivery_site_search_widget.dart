import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';

class DeliverySiteSearchWidget extends StatefulWidget {

  @override
  _DeliverySiteSearchWidgetState createState() => _DeliverySiteSearchWidgetState();
}

class _DeliverySiteSearchWidgetState extends State<DeliverySiteSearchWidget> {

  DeliverySiteModel deliverySiteModel;

  @override
  void initState() {
    super.initState();
    deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 16.0),
      keyboardType: TextInputType.text,
      cursorColor: subTextColor,
      autofocus: false,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '지번, 건물명으로 배달지역 검색',
        prefixIcon: Padding(
          child: IconTheme(
            data: IconThemeData(color: subTextColor, size: 22.0),
            child: Icon(Icons.search),
          ),
          padding: EdgeInsets.only(left: 20, right: 10, bottom: 3),
        )),
      onChanged: (String text) {
        deliverySiteModel.search(query: text);
      },
    );
  }

}
