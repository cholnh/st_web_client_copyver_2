import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/_bases/network/constant/endpoint.dart';
import 'package:stwebclientcopyver2/domains/product/product_summary.dart';
import 'package:stwebclientcopyver2/providers/product/product_model.dart';
import 'package:stwebclientcopyver2/views/pages/product/product_page.dart';
import 'package:provider/provider.dart';

class StoreProductItemWidget extends StatelessWidget {

  final ProductSummary summary;

  StoreProductItemWidget({Key key, this.summary}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProductPage(context),
      child: Container(
        key: key,
        decoration: BoxDecoration(
            border: Border.all(width: 0.3, color: backgroundColor)
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              '${Endpoint.serverDomain}/${summary.productImageMainPath}',
              fit: BoxFit.fill,
              errorBuilder: (context, url, error) => Icon(Icons.error_outline),
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${summary.name}', style: TextStyle(color: Colors.white, fontSize: subTitleFontSize, fontWeight: FontWeight.w500)),
                  Text('${summary.salePrice}', style: TextStyle(color: Colors.white, fontSize: subTitleFontSize, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToProductPage(BuildContext context) {
    Provider.of<ProductModel>(context, listen: false)
    ..product?.productImageSubPaths?.clear()
    ..summary = summary;

    Get.to(ProductPage(pIdx: summary.idx), transition: Transition.cupertino, duration: Duration.zero);
    // Navigator.pushNamed(context, '/products/${summary.idx}');
  }
}
