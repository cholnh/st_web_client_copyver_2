import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_model.dart';

class UserInfoProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<SignInModel>(
        builder: (_, userModel, __) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Row(
                  children: <Widget>[
                    RotationTransition(
                      turns: AlwaysStoppedAnimation(332 / 360),
                      child: Image(
                          image: const AssetImage('assets/logo.png'),
                          width: 50,
                          height: 50
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(right: 13.0)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('${userModel.userInfo.nickname} 님',  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Padding(padding: const EdgeInsets.only(bottom: 5.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Lv${userModel.userInfo.userPointRank.level} ${userModel.userInfo.userPointRank.title} 등급',  style: TextStyle(fontSize: 13.0)),
                              Text('등급별 혜택',  style: TextStyle(fontSize: 13.0, color: primaryColor)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 8.0, height: 30.0, color: Colors.black.withOpacity(0.03)),
            ],
          );
        },
      ),
    );
  }
}
