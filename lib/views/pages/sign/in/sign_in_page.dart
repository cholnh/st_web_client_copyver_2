import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stwebclientcopyver2/_bases/util/string_utils.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_fail_type.dart';
import 'package:stwebclientcopyver2/views/pages/sign/in/sign_in_view_type.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_model.dart';
import 'package:stwebclientcopyver2/views/pages/sign/up/sign_up_page.dart';
import 'package:stwebclientcopyver2/views/pages/sign/up/sign_up_password_page.dart';
import 'package:stwebclientcopyver2/views/pages/sign/up/sign_up_password_view_type.dart';
import 'package:stwebclientcopyver2/views/pages/sign/up/sign_up_without_phone_number_page.dart';
import 'package:stwebclientcopyver2/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:stwebclientcopyver2/views/widgets/sign/in/sign_in_auth_code_help_text_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/sign/in/sign_in_auth_code_input_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/sign/in/sign_in_phone_number_help_text_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/sign/in/sign_in_phone_number_input_widget.dart';
import 'package:stwebclientcopyver2/views/widgets/sign/sign_app_bar.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController _phoneNumberEditingController;
  TextEditingController _authCodeEditingController;

  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _authCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _phoneNumberEditingController = TextEditingController();
    _authCodeEditingController = TextEditingController();

    Provider.of<SignInModel>(context, listen: false)
    ..signInViewType = SignInViewType.PHONE_NUMBER_VIEW
    ..authCodeSendCount = 0;

    _phoneNumberEditingController.text = '010 ';
    _authCodeEditingController.clear();

    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignAppBar(
        context,
        centerTitle: '로그인',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left:20.0, right:20.0, top: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(332 / 360),
                        child: Image(
                          image: const AssetImage('assets/logo.png'),
                          width: 80,
                          height: 80,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    Padding(padding: const EdgeInsets.only(right: 20.0)),
                    Expanded(
                      child: Consumer<SignInModel>(
                        builder: (_, model, __) {
                          if(model.signInViewType == SignInViewType.PHONE_NUMBER_VIEW) {
                            return SignInPhoneNumberHelpTextWidget();
                          } else {
                            return SignInAuthCodeHelpTextWidget();
                          }
                        }
                      )
                    )
                  ],
                ),
                Padding(padding: const EdgeInsets.only(bottom: 20.0)),
                Consumer<SignInModel>(
                  builder: (_, model, __) {
                    if(model.signInViewType == SignInViewType.PHONE_NUMBER_VIEW) {
                      return  SignInPhoneNumberInputWidget(
                          controller: _phoneNumberEditingController,
                          focusNode: _phoneNumberFocusNode,
                          onSelected: _onPhoneNumberSelected,
                          isView: model.signInViewType == SignInViewType.PHONE_NUMBER_VIEW
                      );
                    } else {
                      return SignInAuthCodeInputWidget(
                          controller: _authCodeEditingController,
                          focusNode: _authCodeFocusNode,
                          onSelected: _onAuthCodeSelected,
                          isView: model.signInViewType == SignInViewType.AUTH_CODE_VIEW,
                      );
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPhoneNumberSelected() async {
    SignInModel signInModel = Provider.of<SignInModel>(context, listen: false);
    try {
      signInModel.lockSignInPhoneNumberLock();
      String phoneNumber = _phoneNumberEditingController.text;
      phoneNumber = phoneNumber.replaceAll(' ', '');
      if (!StringUtils.isValidKoreaPhoneNumber(phoneNumber)) {
        DialogUtils.dialog(context, '휴대폰 번호를 확인해주세요. $phoneNumber');
        Future.delayed(Duration(milliseconds: 300), () {
          FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
        });
        return;
      }

      if(signInModel.authCodeSendCount >= signInModel.maxAuthCodeSendCount) {
        DialogUtils.dialog(context, '5분후에 다시 시도해주세요.');
        return;
      }

      if(await signInModel.requestAuthCodeForSignIn(phoneNumber: phoneNumber)) {
        signInModel
          ..changeSignInViewType(SignInViewType.AUTH_CODE_VIEW)
          ..phoneNumber = phoneNumber;

        Future.delayed(Duration(milliseconds: 300), () {
          FocusScope.of(context).requestFocus(_authCodeFocusNode);
        });
      } else {
        DialogUtils.dialog(context, '휴대폰 번호를 확인해주세요.');
      }
    } finally {
      signInModel.unLockSignInPhoneNumberLock();
    }
  }

  void _onAuthCodeSelected() async {
    SignInModel signInModel = Provider.of<SignInModel>(context, listen: false);
    try {
      signInModel.lockSignInAuthCodeLock();  // Lock
      String code = _authCodeEditingController.text;
      if(code.length >= 4) {
        if( await signInModel.verifyAuthCodeForSignIn(code: code) ) {
          signInModel.authCode = code;
          _authCodeEditingController.clear();
          Get.to(SignUpPasswordPage(), arguments: SignUpPasswordViewType.FROM_SIGN_IN, transition: Transition.cupertino, duration: Duration.zero);
        } else {
          if(signInModel.signInFailType == SignInFailType.IN_VALID_PHONE_NUMBER) {
            DialogUtils.dialog(
                context,
                '가입되지 않은 번호이므로,\n회원가입 페이지로 이동합니다.',
                onPressed: (context) => Get.to(SignUpWithoutPhoneNumberPage(), transition: Transition.cupertino, duration: Duration.zero)
            );
          } else {
            DialogUtils.dialog(context, '${signInModel.authCodeFailMessage}');
          }
        }
      } else {
        DialogUtils.dialog(context, '인증번호를 확인해주세요.');
      }
    } finally {
      signInModel.unLockSignInAuthCodeLock(); // Unlock
    }
  }
}