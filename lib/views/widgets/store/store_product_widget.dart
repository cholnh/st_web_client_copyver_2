import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/_bases/key/pmg_key.dart';
import 'package:stwebclientcopyver2/providers/product/product_summary_model.dart';
import 'package:stwebclientcopyver2/views/widgets/store/store_product_item_widget.dart';
import 'package:provider/provider.dart';

class StoreProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSummaryModel>(
      builder: (_, model, child) {
        if(model.productSummaries.length == 0) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: model.isFetching
                  ? CupertinoActivityIndicator()
                  : Text('주문가능한 메뉴가 없습니다.', style: TextStyle(color: subTextColor, fontSize: 14)),
              ),
            ),
          );
        }
        return SliverGrid(
          key: PmgKeys.storeProduct,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return StoreProductItemWidget(
                key: PmgKeys.storeProductItem(model.productSummaries[index].idx),
                summary: model.productSummaries[index]
            );
          },
          childCount: model.productSummaries.length)
        );
      },
    );
  }
}