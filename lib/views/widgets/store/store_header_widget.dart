import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/key/pmg_key.dart';
import 'package:stwebclientcopyver2/_bases/network/constant/endpoint.dart';
import 'package:stwebclientcopyver2/providers/store/store_model.dart';
import 'package:stwebclientcopyver2/views/widgets/store/store_brand_image_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/store/store_score_widget.dart';
import 'package:provider/provider.dart';

class StoreHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeHeader,
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 7.0, bottom: 15.0),
        child: Consumer<StoreModel>(
          builder: (_, model, child) {
            return Row(
              children: <Widget>[
                StoreBrandImageWidget(
                    brandImagePath: '${Endpoint.serverDomain}/${model.summary?.brandImagePath}'
                ),
                Expanded(
                  child: StoreScoreWidget(
                    avgStar: model.summary?.avgStar ?? 0,
                    cntLike: model.summary?.cntLike ?? 0,
                    cntComment: model.summary?.cntReview ?? 0
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
