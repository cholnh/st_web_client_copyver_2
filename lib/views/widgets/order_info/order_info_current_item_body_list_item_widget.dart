import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/_bases/network/constant/endpoint.dart';
import 'package:stwebclientcopyver2/_bases/util/string_utils.dart';

class OrderInfoCurrentItemBodyListItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(right: 5.0),
                    child: CircleAvatar(
                        child: Image.network(
                          '${Endpoint.serverDomain}/assets/images/dsites/1/stores/1/brand.png',
                          fit: BoxFit.fill,
                          width: 12.0,
                          height: 12.0,
                          errorBuilder: (context, url, error) => Icon(Icons.error_outline),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white
                    ),
                    width: 18.0,
                    height: 18.0,
                    padding: const EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    )
                ),
                Text('반찬탁(탄현점)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
              ],
            ),
          ],
        ),
        Padding(padding: const EdgeInsets.only(bottom: 10.0)),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('제육볶음 500g 1개', style: TextStyle(fontSize: 14.0)),
                  Text('${StringUtils.comma(8900)}원', style: TextStyle(fontSize: 13.0)),
                ],
              ),
              Padding(padding: const EdgeInsets.only(bottom: 5.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(' - 저번 보다는 덜 짜게 해주세요.', style: TextStyle(fontSize: 13.0, color: subTextColor))
                ],
              ),
              Padding(padding: const EdgeInsets.only(bottom: 5.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('꽈리고추 멸치볶음 100g 1개', style: TextStyle(fontSize: 14.0)),
                  Text('${StringUtils.comma(2900)}원', style: TextStyle(fontSize: 13.0)),
                ],
              ),
              Padding(padding: const EdgeInsets.only(bottom: 5.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('볶음김치 100g 1개', style: TextStyle(fontSize: 14.0)),
                  Text('${StringUtils.comma(2900)}원', style: TextStyle(fontSize: 13.0)),
                ],
              ),
              Divider(height: 20.0, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('주문금액', style: TextStyle(fontSize: 13.0)),
                  Text('${StringUtils.comma(14700)}원', style: TextStyle(fontSize: 13.0)),
                ],
              ),
              Padding(padding: const EdgeInsets.only(bottom: 5.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('포인트', style: TextStyle(fontSize: 13.0)),
                  Text('- ${StringUtils.comma(500)}원', style: TextStyle(fontSize: 13.0)),
                ],
              ),
              Padding(padding: const EdgeInsets.only(bottom: 5.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('쿠폰 (6월 이벤트 쿠폰)', style: TextStyle(fontSize: 13.0)),
                  Text('- ${StringUtils.comma(3000)}원', style: TextStyle(fontSize: 13.0)),
                ],
              ),
              Divider(height: 20.0, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('합계', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
                  Text('${StringUtils.comma(11200)}원', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),


      ],
    );
  }

}
