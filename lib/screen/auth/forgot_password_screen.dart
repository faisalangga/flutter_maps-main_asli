import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: ()=>Get.back(),
            child: Icon(CupertinoIcons.back, color: Colors.black87)
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.15),
              Center(child: Image.asset(ImageConstant.ilus_forgot_pass, height: size.height * 0.20)),
              SizedBox(height: 45),
              Text('Lupa\nKata Sandi?', style: TextConstant.regular.copyWith(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black87),),
              SizedBox(height: 30),
              Text('Jangan khawatir, Silahkan masukkan nomor telepon yang terhubung dengan akun anda', style: TextConstant.regular.copyWith(fontSize: 14, color: Colors.black87),),
              SizedBox(height: 45),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.phone_android_rounded, size: 24, color: Colors.grey.shade500),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: TextField(
                          maxLength: 25,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                            FilteringTextInputFormatter.deny(RegExp('[\\-|\\,|\\.|\\#|\\*]'))
                          ],
                          decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan nomor teleponmu",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              ButtonGreenWidget(text: 'Submit', onClick: ()=>Get.back(),),
            ],
          ),
        ),
      ),
    );
  }
}
