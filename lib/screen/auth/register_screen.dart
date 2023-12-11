import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/controller/auth_controller.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  AuthController registercontroller = AuthController();

  bool _obscureText = true;
  bool _obscureText1 = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.back, color: Colors.black87)),
        title: Text(
          '',
          style: TextConstant.regular.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.05),
              Center(child: Image.asset(ImageConstant.cart_logo, height: size.height * 0.13)),
              SizedBox(height: 25),
              Text('              Buat User Login', style: TextConstant.regular.copyWith(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black87),),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        controller: registercontroller.edtNama,
                        keyboardType: TextInputType.text,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan Nama",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 50,
                        controller: registercontroller.edtEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan Email",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No. Telepon', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        controller: registercontroller.edtNohp,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.deny(RegExp('[\\-|\\,|\\.|\\#|\\*]'))
                        ],
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan nomor teleponmu",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kata Sandi', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 10,
                        controller: registercontroller.edtPass,
                        obscureText: _obscureText,
                        decoration: DecorationConstant.inputDecor().copyWith(
                            hintText: "Masukkan Kata Sandi",
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 0),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            suffixIconColor: Colors.grey.shade500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Konfirmasi Kata Sandi', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 10,
                        controller: registercontroller.edtConfirmPass,
                        obscureText: _obscureText1,
                        decoration: DecorationConstant.inputDecor().copyWith(
                            hintText: "Masukkan Konfirmasi Kata Sandi",
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText1 = !_obscureText1;
                              });
                            },
                          ),
                          suffixIconColor: Colors.grey.shade500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 35),
              ButtonGreenWidget(
                text: 'Daftar', 
                onClick: ()=>registercontroller.validationRegister(
                  context: context,
                  callback: (result, error){
                    if(result != null && result['error'] != true){
                      Get.back();
                      DialogConstant.alertError('Pendaftaran Berhasil');
                    }
                    if(error != null){
                      DialogConstant.alertError('Pendaftaran Gagal, Username Sudah Ada !!');
                    }
                  }
                ),),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: ()=>Get.back(),
                  child: RichText(
                    text: TextSpan(
                      text: 'Sudah punya akun ? ',
                      style: TextConstant.regular,
                      children: <TextSpan>[
                        TextSpan(text: 'Login', style: TextConstant.regular.copyWith(
                            color: Colors.green
                        )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
