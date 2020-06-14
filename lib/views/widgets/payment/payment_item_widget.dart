import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';

class PaymentItemWidget extends StatelessWidget {

  final String title;
  final String subTitle;
  final Widget trailing;
  final Function onSelected;
  final bool isActive;

  PaymentItemWidget({
    this.title, this.subTitle, this.onSelected, this.isActive = true,
    this.trailing = const Icon(Icons.chevron_right, color: Color.fromRGBO(0x2e, 0x2e, 0x2e, 0.5))
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => isActive ? onSelected() : {},
        child: Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Opacity(
                  opacity: isActive ? 1.0 : 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('$title', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal)),
                          Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                          subTitle != null ? Text('$subTitle', style: TextStyle(fontSize: 13.0, color: subTextColor)) : Container()
                        ],
                      ),
                      trailing
                    ],
                  ),
                ),
                Divider(height: 30.0, thickness: 0.5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
