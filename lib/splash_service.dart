import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/session_constant.dart';
import 'package:koperasimobile/screen/auth/login_screen.dart';
import 'package:koperasimobile/screen/home/landing_home.dart';
import 'package:koperasimobile/utils/local_data.dart';
import 'package:page_transition/page_transition.dart';

class SplashService {
  Future<bool> isLogin() => LocalData.getDataBool(ConstSession.ISLOGIN);

  void checkAuthentication(BuildContext context) {
    // print('fais isLogin : ${isLogin().toString()}');
    isLogin().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const LandingHome(),
                reverseDuration: const Duration(milliseconds: 2000),
                duration: const Duration(milliseconds: 2000),
                type: PageTransitionType.fade));
      } else {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const LoginScreen(logout: ''),
                reverseDuration: const Duration(milliseconds: 2000),
                duration: const Duration(milliseconds: 2000),
                type: PageTransitionType.fade
            )
        );
      }
    });
  }
}
