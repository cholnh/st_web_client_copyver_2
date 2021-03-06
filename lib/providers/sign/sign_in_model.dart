import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:stwebclientcopyver2/providers/sign/sign_in_fail_type.dart';
import 'package:stwebclientcopyver2/views/pages/sign/in/sign_in_view_type.dart';
import 'package:stwebclientcopyver2/domains/user/auth_code_result.dart';
import 'package:stwebclientcopyver2/domains/user/enum/sign_in_state.dart';
import 'package:stwebclientcopyver2/domains/user/user.dart';
import 'package:stwebclientcopyver2/repositories/sign/sign_repository.dart';

class SignInModel with ChangeNotifier {
  SignRepository _signRepository;

  SignInState signState = SignInState.SIGNED_OUT;
  User userInfo;

  String phoneNumber;
  String authCode;

  // authCode page
  SignInViewType signInViewType = SignInViewType.PHONE_NUMBER_VIEW;
  bool isAuthCodeFilled = false;
  final int maxAuthCodeSendCount = 5;
  int authCodeSendCount = 0;

  String authCodeFailMessage;
  SignInFailType signInFailType;

  // password page
  Widget returnPage;
  List<String> predicateUrl;
  Object arguments;
  final int maxPasswordTryCount = 5;
  int passwordTryCount = 0;
  String passwordFailMessage;

  bool signInPhoneNumberLock = false;
  bool signInAuthCodeLock = false;
  bool signInPasswordLock = false;

  SignInModel() {
    _signRepository = Injector.appInstance.getDependency<SignRepository>();
  }

  Future<bool> signIn({
    @required String phoneNumber,
    @required String password
  }) async {
    if(phoneNumber == null || phoneNumber.isEmpty ||
        password == null || password.isEmpty) {
      signState = SignInState.SIGNED_FAIL;
      notifyListeners();
      return null;
    } else {
      signState = SignInState.SIGNING_IN;
      notifyListeners();

      try {
        passwordTryCount++;

        //print('$phoneNumber $password');
        userInfo = await _signRepository.signIn(
          phoneNumber: phoneNumber,
          password: password
        );
      } catch(error) {
        signState = SignInState.SIGNED_FAIL;
        notifyListeners();
        return false;
      }

      signState = SignInState.SIGNED_IN;
      notifyListeners();
      return true;
    }
  }

  Future<bool> requestAuthCodeForSignIn({
    @required String phoneNumber
  }) async {
    bool isValid = false;
    if(phoneNumber != null && phoneNumber.isNotEmpty) {
      AuthCodeResult result;

      try {
        authCodeSendCount++;
        result = await _signRepository.requestAuthCodeForId(phoneNumber: phoneNumber);
      } catch(error) {
        isValid = false;
      }

      if(result != null && result.code == 'success') {
        isValid = true;
      }
    }
    notifyListeners();
    return isValid;
  }

  Future<bool> verifyAuthCodeForSignIn({
    @required String code
  }) async {
    bool isValid;
    try {
      isValid = await _signRepository.verifyAuthCodeForId(phoneNumber: phoneNumber, code: code);
      if(!isValid) {
        signInFailType = SignInFailType.IN_VALID_PHONE_NUMBER;
        authCodeFailMessage = '가입되지 않은 번호입니다.';
      }
    } catch(error) {
      isValid = false;
      signInFailType = SignInFailType.IN_VALID_AUTH_CODE;
      authCodeFailMessage = '인증번호를 확인해주세요.';
    }
    return isValid;
  }

  Future<void> signOut({bool notify = false}) async {
    userInfo = null;
    signState = SignInState.SIGNED_OUT;
    await _signRepository.signOut(trySignInGuest: true);
    if(notify) {
      notifyListeners();
    }
  }

  bool isSignIn() {
    return this.signState == SignInState.SIGNED_IN;
  }

  changeSignInViewType(SignInViewType signInViewType) {
    this.signInViewType = signInViewType;
    notifyListeners();
  }

  void lockSignInPhoneNumberLock() {
    signInPhoneNumberLock = true;
    notifyListeners();
  }

  void unLockSignInPhoneNumberLock() {
    signInPhoneNumberLock = false;
    notifyListeners();
  }

  void lockSignInAuthCodeLock() {
    signInAuthCodeLock = true;
    notifyListeners();
  }

  void unLockSignInAuthCodeLock() {
    signInAuthCodeLock = false;
    notifyListeners();
  }

  void lockSignInPasswordLock() {
    signInPasswordLock = true;
    notifyListeners();
  }

  void unLockSignInPasswordLock() {
    signInPasswordLock = false;
    notifyListeners();
  }

}