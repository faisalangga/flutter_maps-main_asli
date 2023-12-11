import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/screen/home/main_home.dart';
import 'package:koperasimobile/widget/appbar_widget.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

class SuksesCheckout extends StatelessWidget {
  const SuksesCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Sukses'),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.checkmark_alt_circle, color: Colors.green, size: 88,),
              SizedBox(height: 10),
              Text('Pembayaran Kamu berhasil', style: TextConstant.regular.copyWith(fontSize: 18, color: Colors.black87),)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ButtonGreenWidget(
              onClick: ()=>Get.offAll(MainHome()),
              text: 'Belanja Kembali',
            ),
          )
        ],
      ),
    );
  }
}
