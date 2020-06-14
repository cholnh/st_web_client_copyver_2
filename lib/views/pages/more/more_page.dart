import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/cart/cart_model.dart';
import 'package:stwebclientcopyver2/providers/coupon/coupon_model.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_model.dart';
import 'package:stwebclientcopyver2/views/widgets/_bases/tab_selector.dart';
import 'package:stwebclientcopyver2/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  bool _saving = false;
  bool _bedroom = false;

  _submit() {
    setState(() {
      _saving = true;
    });

    print('submitting to backend...');
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _saving = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('뒤로가기');
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: TabSelector(),
        body: SafeArea(
          child: Center(
            child: ModalProgressHUD(
              inAsyncCall: _saving,
              child: Form(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Bedroom'),
                      value: _bedroom,
                      onChanged: (bool value) {
                        setState(() {
                          _bedroom = value;
                        });
                      },
                      secondary: const Icon(Icons.hotel),
                    ),
                    RaisedButton(
                      onPressed: _submit,
                      child: Text('Save'),
                    ),
                    Divider(),
                    RaisedButton(
                      onPressed: () => showSignModal(context: context),
                      child: Text('Login'),
                    ),
                    RaisedButton(
                      onPressed: () => _logout(context),
                      child: Text('Logout'),
                    ),
                    Divider(),
                    RaisedButton(
                      onPressed: () => _bootPay(),
                      child: Text('BootPay 결제'),
                    ),
                  ],
                ),
              ),

            ),
          ),
        ),
      ),
    );
  }

  void _bootPay() async {
    MethodChannel platform = const MethodChannel('com.mrporter.pomangam/bootpay');

    String result;
    try {
      result = await platform.invokeMethod('openPay');
    } on PlatformException catch (e) {
      print('error!!!! $e');
    }
    print(result);
  }

  void _logout(BuildContext context) {
    Provider.of<SignInModel>(context, listen: false).signOut();
    Provider.of<CartModel>(context, listen: false).clear(clearItems: false);
    Provider.of<CouponModel>(context, listen: false).clear();

    Fluttertoast.showToast(
        msg: "로그아웃 되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: titleFontSize
    );
  }
}
