import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/domains/product/product.dart';
import 'package:stwebclientcopyver2/providers/product/product_model.dart';
import 'package:stwebclientcopyver2/views/widgets/home/contents/home_contents_item_like_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/home/contents/home_contents_item_sub_title_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/product/product_count_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/product/product_image_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/product/product_price_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/product/product_review_widget.dart';
import 'package:provider/provider.dart';

class ProductContentsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<ProductModel>(
        builder: (_, model, child) {
          Product product = model.product;
          return Column(
            children: <Widget>[
              ProductImageWidget(),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              HomeContentsItemLikeWidget(
                cntLike: product?.cntLike ?? 0,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 7.0)),
              HomeContentsItemSubTitleWidget(
                  title: product?.productInfo?.name ?? '',
                  description: product?.productInfo?.description ?? ''
              ),
              const Padding(padding: EdgeInsets.only(bottom: 7.0)),
              ProductReviewWidget(
                cntComment: product?.cntReply ?? 0,
                previews: product?.replies ?? List(),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Divider(height: 0.5, thickness: 0.5),
              const Padding(padding: EdgeInsets.only(bottom: 15.0)),
              ProductPriceWidget(),
              const Padding(padding: EdgeInsets.only(bottom: 7.0)),
              ProductCountWidget(),
              const Padding(padding: EdgeInsets.only(bottom: 20.0)),
              Divider(height: 0.5, thickness: 0.5),
            ],
          );
        }
      ),
    );
  }
}