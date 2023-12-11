import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koperasimobile/splash_service.dart';
import 'package:koperasimobile/utils/local_data.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'constant/session_constant.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    SplashService splashService = SplashService();
    _initPackageInfo();
    Timer(const Duration(seconds: 3),
        () => splashService.checkAuthentication(context));
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      LocalData.saveData(ConstSession.CVERSION, _packageInfo.version);
      LocalData.saveData(ConstSession.CCODEVERSION, _packageInfo.buildNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/images/logokoperasi.svg',
              height: width * 0.7,
              width: width * 0.7,
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
                width: width,
                child: Center(
                    child:
                    Text("Version ${_packageInfo.version}")
                )
            ),
          )
        ],
      ),
    );
  }
}
