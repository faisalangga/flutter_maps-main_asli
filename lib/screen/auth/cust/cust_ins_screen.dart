// ignore_for_file: duplicate_import, unused_import, unnecessary_statements
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/controller/cust_controller.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

import '../../home/view/cust_screen.dart';
// import '../home/view/cust_screen.dart';

class CustInsScreen extends StatefulWidget {
  final String tipeCheck;
  const CustInsScreen({Key? key, required this.tipeCheck}) : super(key: key);


  @override
  State<CustInsScreen> createState() => _CustScreenState();
  // printInfo(tipeCheck)
}

class _CustScreenState extends State<CustInsScreen> {
  CustController custcontroller = CustController();
  List<String> data =[
    "Brazil", "Italia (Disabled)", "Tunisia", 'Canada'
  ];

  @override
  void initState() {
    super.initState();
    print(widget.tipeCheck);
    // data  = custcontroller.edtKodes.text as List<String>;
    // print(data);
  }

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
              SizedBox(height: size.height * 0.05),
              Center(child: Image.asset(ImageConstant.cart_logo, height: size.height * 0.15)),
              SizedBox(height: 45),
              Text('Buat Cust Baru', style: TextConstant.regular.copyWith(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black87),),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kode', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 10,
                        controller: custcontroller.edtKodes,
                        keyboardType: TextInputType.text,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan Kode",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
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
                    Text('Nama', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 50,
                        controller: custcontroller.edtNama,
                        keyboardType: TextInputType.text,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan Nama",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text('Alamat', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                //     Container(
                //       height: 40,
                //       child: TextField(
                //         maxLength: 50,
                //         controller: custcontroller.edtAlamat,
                //         keyboardType: TextInputType.text,
                //         decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan Alamat",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                //       ),
                //     )
                //   ],
                // ),
                child: Padding(
                padding: const EdgeInsets.all(0),
                child:DropdownSearch<String>(
                  clearButtonProps: ClearButtonProps(isVisible: true),
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    // disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: data,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      // border : OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(0),
                      // ),
                      labelText : ('Alamat'),
                      hintText: "",
                    ),
                  ),
                  onChanged: (value){
                    setState((){
                     value;
                    });
                    print('XXXX $value');
                  },
                )
              ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No.Telepon', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        controller: custcontroller.edtNohp,
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
                    Text('Email', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        controller: custcontroller.edtEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan Email",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                      ),
                    )
                  ],
                ),
              ),SizedBox(height: 20),
              // Container(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text('Golongan', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
              //       Container(
              //         height: 40,
              //         child: TextField(
              //           maxLength: 25,
              //           controller: suppcontroller.edtEmail,
              //           keyboardType: TextInputType.emailAddress,
              //           decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan Email",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(height: 35),
              ButtonGreenWidget(
                text: 'Daftar', 
                onClick: ()=>custcontroller.validationSupp(
                  context: context,
                  callback: (result, error){
                    if(result != null && result['error'] != true){
                      Get.back();
                      DialogConstant.alertError('Pendaftaran Berhasil');
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>CustScreen(),));
                      setState(() {
                      });
                    }
                    if(error != null){
                      DialogConstant.alertError('Pendaftaran Gagal');
                    }
                  }
                ),),
              SizedBox(height: 20),
              // Center(
              //   child: GestureDetector(
              //     onTap: ()=>Get.back(),
              //     child: RichText(
              //       text: TextSpan(
              //         text: 'Kode Supp Sudah Ada ? ',
              //         style: TextConstant.regular,
              //         children: <TextSpan>[
              //           TextSpan(text: '', style: TextConstant.regular.copyWith(
              //               color: Colors.orange
              //           )),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
