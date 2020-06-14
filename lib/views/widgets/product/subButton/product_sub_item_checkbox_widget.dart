import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/_bases/util/string_utils.dart';
import 'package:stwebclientcopyver2/domains/product/sub/category/product_sub_category.dart';
import 'package:stwebclientcopyver2/domains/product/sub/product_sub.dart';
import 'package:stwebclientcopyver2/providers/product/product_model.dart';
import 'package:provider/provider.dart';

class ProductSubItemCheckBoxWidget extends StatelessWidget {

  final ProductSub sub;
  final ProductSubCategory productSubCategory;

  ProductSubItemCheckBoxWidget({this.sub, this.productSubCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ProductModel>(context, listen: false).toggleProductSubIsSelected(
            productSubCategory: productSubCategory,
            subIdx: sub.idx,
            isRadio: false
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.only(right: 20.0),
        subtitle: sub?.productSubInfo?.description != null
            ? Text('${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}', style: TextStyle(fontSize: subTitleFontSize))
            : null,
        leading: Checkbox(
          value: sub.isSelected,
        ),
        title: Text('${sub.productSubInfo?.name ?? ''}', style: TextStyle(fontSize: titleFontSize)),
        trailing: Text('+ ${StringUtils.comma(sub?.salePrice)}원', style: TextStyle(fontSize: titleFontSize)),
      ),
    );
  }
}
