import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'dart:js' as js;

class HomeNavigationRightFooterWidget extends StatelessWidget {

  HomeNavigationRightFooterWidget();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openWebSite('https://www.facebook.com/pomangam'),
                    child: Container(
                      child: Image(
                        image: const AssetImage('assets/facebook_v2.png'),
                        height: 30,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openWebSite('https://www.instagram.com/pomangam_official'),
                    child: Container(
                      child: Image(
                        image: const AssetImage('assets/instagram_v2.png'),
                        height: 30,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openWebSite('https://pf.kakao.com/_xlxbhlj'),
                    child: Container(
                      child: Image(
                        image: const AssetImage('assets/kakao_v2.png'),
                        height: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openWebSite(String url) {
    //js.context.callMethod('open', [url]);
  }
}
