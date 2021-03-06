import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/_bases/key/pmg_key.dart';
import 'package:stwebclientcopyver2/providers/store/store_summary_model.dart';
import 'package:stwebclientcopyver2/views/widgets/home/contents/home_contents_item_widget.dart';
import 'package:provider/provider.dart';

class HomeContentsWidget extends StatelessWidget {

  HomeContentsWidget();

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreSummaryModel>(
      builder: (_, model, child) {
        if(model.stores.length == 0) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: model.isFetching
                  ? CupertinoActivityIndicator()
                  : Text('주문가능한 업체가 없습니다.', style: TextStyle(color: subTextColor, fontSize: 14)),
              ),
            ),
          );
        }
        return SliverList(
          key: PmgKeys.deliveryContents,
          delegate: SliverChildBuilderDelegate((context, index) {
            return index >= model.stores.length
              ? Container()
              : HomeContentsItemWidget(
                  key: PmgKeys.homeContentsItem(model.stores[index].idx),
                  summary: model.stores[index]
                );
          },
          childCount: model.hasReachedMax
            ? model.stores.length
            : model.stores.length + 1
          ),
        );
      }
    );
  }
}
