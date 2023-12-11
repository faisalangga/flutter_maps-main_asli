// ignore_for_file: duplicate_import, unused_import, avoid_web_libraries_in_flutter
import 'dart:convert';
// import 'dart:js';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/controller/cust_controller.dart';
import 'package:koperasimobile/screen/home/cust_home.dart';
import 'package:koperasimobile/screen/home/view/cust_screen.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

import '../../../controller/cust_controller.dart';

class CustEdtScreen extends StatefulWidget {
  final String tipeCheck;
  // final Map<String, dynamic> map;
  final String kodes;
  final String namas;
  final String alamat;
  final String email;
  final String tlp;

  const CustEdtScreen({Key? key, required this.tipeCheck,
    required this.kodes, required this.namas, required this.alamat, required this.email,
    required this.tlp})
      : super(key: key);


  @override
  State<CustEdtScreen> createState() => _CustScreenState();
// printInfo(tipeCheck)
}

class _CustScreenState extends State<CustEdtScreen> {
  CustController custcontroller = CustController();

  get edtKodes => custcontroller.edtKodes;
  get edtNama => "";
  get edtAlamat => "";
  get edtNohp => "";
  get edtEmail => "";

  @override
  void initState() {
    custcontroller.edtKodes.text= widget.kodes;
    custcontroller.edtNama.text= widget.namas;
    custcontroller.edtAlamat.text= widget.alamat;
    custcontroller.edtNohp.text= widget.tlp;
    custcontroller.edtEmail.text  = widget.email;

    super.initState();
    print(widget.tipeCheck);
    print(edtKodes);
    // List myMap = widget.map.values.toList();
    // print(myMap);
    // print(map['kodes']);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.back, color: Colors.black87)),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.05),
              Center(
                  child: Image.asset(ImageConstant.cart_logo,
                      height: size.height * 0.15)),
              SizedBox(height: 45),
              Text(
                'Edit Data Customer',
                style: TextConstant.regular.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kode',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 10,
                        controller: edtKodes,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        decoration: DecorationConstant.inputDecor().copyWith(
                            hintText: "Masukkan Kode",
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 0)),
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
                    Text(
                      'Nama',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 50,
                        controller: custcontroller.edtNama,
                        keyboardType: TextInputType.text,
                        decoration: DecorationConstant.inputDecor().copyWith(
                            hintText: "Masukkan Nama",
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 0)),
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
                    Text(
                      'Alamat',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 50,
                        controller: custcontroller.edtAlamat,
                        keyboardType: TextInputType.text,
                        decoration: DecorationConstant.inputDecor().copyWith(
                            hintText: "Masukkan Alamat",
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 0)),
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
                    Text(
                      'No.Telepon',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        controller: custcontroller.edtNohp,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.deny(
                              RegExp('[\\-|\\,|\\.|\\#|\\*]'))
                        ],
                        decoration: DecorationConstant.inputDecor().copyWith(
                            hintText: "Masukkan nomor teleponmu",
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 0)),
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
                    Text(
                      'Email',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        controller: custcontroller.edtEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: DecorationConstant.inputDecor().copyWith(
                            hintText: "Masukkan Email",
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 0)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 35),
              ButtonGreenWidget(
                text: 'Simpan',
                onClick: () => custcontroller.editsupp(
                    context: context,
                    callback: (result, error) {
                      if (result != null && result['error'] != true) {
                        // Get.back();
                        // Get.to(SuppScreen());
                        Get.off(CustHome());
                        DialogConstant.alertError('Edit Data Berhasil');
                      }
                      if (error != null) {
                        DialogConstant.alertError('Edit Data Gagal');
                      }
                    }),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
