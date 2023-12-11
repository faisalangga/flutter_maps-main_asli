import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:lottie/lottie.dart';

class AppNoData extends StatelessWidget {
  final  String ket;
  const AppNoData({super.key, required this.ket});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Center(
        child: Container(
          width: width,
          height: height*0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(ImageConstant.lotienodata,
                  fit: BoxFit.contain),
              Text(
                ket,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ));
  }
}
