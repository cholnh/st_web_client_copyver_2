import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';

class UserInfoCategoryTitleWidget extends StatelessWidget {
  final String title;

  UserInfoCategoryTitleWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: primaryColor)),
            Divider(height: 30.0, thickness: 0.5)
          ],
        ),
      ),
    );
  }
}
