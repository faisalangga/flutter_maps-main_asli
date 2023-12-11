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
import 'package:koperasimobile/controller/kas_controller.dart';
import 'package:koperasimobile/screen/home/kas_home.dart';
import 'package:koperasimobile/screen/home/view/kas_screen.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

class KasEdtScreen extends StatefulWidget {
  final String tipeCheck;
  // final Map<String, dynamic> map;
  final String bkt;
  final String tgl;
  final String ket;
  final String tot;
  final String acno;
  final String nacno;
  final String uraian;
  final String jml;
  final String reff;

  const KasEdtScreen({Key? key, required this.tipeCheck,
    required this.bkt, required this.tgl, required this.ket, required this.tot,
    required this.acno,required this.nacno,required this.uraian,required this.jml,required this.reff})
      : super(key: key);


  @override
  State<KasEdtScreen> createState() => _KasScreenState();
// printInfo(tipeCheck)
}

class _KasScreenState extends State<KasEdtScreen> {
  KasController kascontroller = KasController();

  get edtBkt    => kascontroller.edtNbkt;
  get edtTgl    => "";
  get edtKet    => "";
  get edtTotal  => "";
  get edtEmail  => "";
  get edtAcno   => "";

  @override
  void initState() {
    kascontroller.edtNbkt.text= widget.bkt;
    kascontroller.edtTgl.text= widget.tgl;
    kascontroller.edtKet.text= widget.ket;
    kascontroller.edtTotal.text= widget.tot;
    kascontroller.edtAcno.text  = widget.acno;

    super.initState();
    print(widget.tipeCheck);
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
                'Edit Data Supplier',
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
                        controller: edtBkt,
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
                        controller: kascontroller.edtTgl,
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
                        controller: kascontroller.edtKet,
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
                        controller: kascontroller.edtAcno,
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
                        controller: kascontroller.edtTotal,
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
                onClick: () => kascontroller.editsupp(
                    context: context,
                    callback: (result, error) {
                      if (result != null && result['error'] != true) {
                        // Get.back();
                        // Get.to(SuppScreen());
                        Get.off(KasHome());
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
