import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/widget/appbar_widget.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

class TambahAlamatScreen extends StatelessWidget {
  const TambahAlamatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Alamat'),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              section('Alamat Sebagai'),
              SizedBox(height: 10),
              section('Nama Penerima'),
              SizedBox(height: 10),
              section('Nomor Telepon Penerima'),
              SizedBox(height: 10),
              section('Email Penerima'),
              SizedBox(height: 10),
              section('Kota/Kecamatan'),
              SizedBox(height: 10),
              section('Kode Pos'),
              SizedBox(height: 10),
              section('Detail Alamat'),
              SizedBox(height: 10),
              section('Pesan'),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ButtonGreenWidget(
              onClick: ()=>Get.back(),
              text: 'Simpan',
            ),
          )
        ],
      ),
    );
  }

  section(String title){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
          Container(
            height: 40,
            child: TextField(
              maxLength: 25,
              // controller: controller.edtConfirmPass,
              obscureText: true,
              decoration: DecorationConstant.inputDecor().copyWith(hintText: title,counterText: '', contentPadding: EdgeInsets.only(top: 0)),
            ),
          )
        ],
      ),
    );
  }
}
