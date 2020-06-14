import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/_bases/network/constant/endpoint.dart';

class EventItemWidget extends StatelessWidget {

  final int index;
  final String title;
  final String subTitle;
  final String trailingText;
  final Color trailingColor;
  final Function onTap;

  EventItemWidget({this.index, this.title, this.subTitle, this.trailingText, this.trailingColor = primaryColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$title',
                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)
                    ),
                    Padding(padding: const EdgeInsets.only(bottom: 3.0)),
                    Text(
                      '$subTitle',
                      style: TextStyle(fontSize: 12.0, color: subTextColor),
                    )
                  ],
                ),
                Text(
                  '$trailingText',
                  style: TextStyle(fontSize: 12.0, color: trailingColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(padding: const EdgeInsets.only(bottom: 7.0)),
            Image.network(
                '${Endpoint.serverDomain}/assets/images/_bases/events/${index+1}.png',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline)
            ),
            Padding(padding: const EdgeInsets.only(bottom: 20.0)),
            Divider(height: 0.5, thickness: 0.5),
            Padding(padding: const EdgeInsets.only(bottom: 20.0))
          ],
        ),
      ),
    );
  }
}