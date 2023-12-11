import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/controller/home_controller.dart';
import 'package:koperasimobile/screen/home/view/landing_screen.dart';
import 'package:koperasimobile/screen/home/view/profile_screen.dart';
import 'package:lottie/lottie.dart';

import '../../constant/image_constant.dart';

class LandingHome extends StatefulWidget {
  const LandingHome({Key? key}) : super(key: key);

  @override
  State<LandingHome> createState() => _LandingHomeState();
}

class _LandingHomeState extends State<LandingHome> {
  String? saldopnjString;

  String? saldosimpString;

  String? cmember;

  PageController controller = PageController();

  HomeController homeController = Get.put(HomeController());

  DateTime newTime = DateTime.now();

  DateTime oldTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Container(
          child: PageView(
            controller: controller,
            // physics: BouncingScrollPhysics(),
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              LandingScreen(),
              ProfileScreen(),
            ],
            onPageChanged: (val) => homeController.changeLandingPage(val),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
                backgroundColor: Colors.greenAccent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                label: 'Profile',
                backgroundColor: Colors.greenAccent,
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey.shade400,
            showUnselectedLabels: false,
            currentIndex: homeController.posLandingPage.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            onTap: (val) {
              homeController.changeLandingPage(val);
              controller.animateToPage(val,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.bounceOut);
            },
          )),
    );
  }

  Future<bool> onBackPress() async {
    newTime = DateTime.now();
    int difference = newTime.difference(oldTime).inMilliseconds;
    oldTime = newTime;
    if (difference < 2000) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      SystemNavigator.pop();
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                ImageConstant.closeexit,
                fit: BoxFit.contain,
                width: 50,
                height: 50,
              ),
              Text(
                'Tap 2 kali untuk keluar',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      );
      return false;
    }
  }
}
