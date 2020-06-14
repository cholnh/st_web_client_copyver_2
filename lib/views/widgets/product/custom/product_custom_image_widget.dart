import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/domains/product/product_type.dart';
import 'package:stwebclientcopyver2/providers/product/product_model.dart';
import 'package:stwebclientcopyver2/views/widgets/product/custom/product_custom_image_3_widget.dart';
import 'package:provider/provider.dart';

class ProductCustomImageWidget extends StatelessWidget {

  final ProductType productType;
  final Function(int, int) onSelected;

  ProductCustomImageWidget({this.productType, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (_, model, child) {
        return ProductCustomImage3Widget(
          onSelected: onSelected,
        );
      },
    );
  }
}