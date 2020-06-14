import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_model.dart';
import 'package:stwebclientcopyver2/views/pages/sign/in/sign_in_page.dart';
import 'package:stwebclientcopyver2/views/pages/user_info/user_info_page.dart';
import 'package:stwebclientcopyver2/views/widgets/home/navigation/home_navigation_right_body_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/home/navigation/home_navigation_right_header_widget.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

class HomeNavigationRightWidget extends StatelessWidget {

  final GlobalKey<InnerDrawerState> innerDrawerKey;

  HomeNavigationRightWidget({this.innerDrawerKey});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSignIn = Provider.of<SignInModel>(context, listen: false).isSignIn();

    return SafeArea(
      child: Scaffold(
        backgroundColor: sideMenuBackgroundColor,
        // appBar: HomeNavigationAppBar(onCloseTap: _onCloseTap),
        body: Column( // Todo. app 버전에서는 SingleChildScrollView 를 부모로 올려서 사용하면 됨. (로그인하고 뒤로 오면, 키보드가 올라가 있어서 렌더링이 오버플로우 됨.)
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top: 20.0)),
            HomeNavigationRightHeaderWidget(
              width: size.width * 0.7,
              onTap: isSignIn
                ? () => Get.to(UserInfoPage(), duration: Duration.zero)
                : () => Get.to(SignInPage(), duration: Duration.zero),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15.0)),
            Divider(thickness: 8.0, color: sideMenuDividerColor),
            HomeNavigationRightBodyWidget(
              height: size.height * 0.5,
            ),
            // Divider(height: 30.0, thickness: 8.0, color: Colors.black.withOpacity(0.03)),
            // kIsWeb ? HomeNavigationRightFooterWidget() : Container()
          ],
        )
      ),
    );
  }

  void _onCloseTap() {
    innerDrawerKey.currentState.close();
  }
}
