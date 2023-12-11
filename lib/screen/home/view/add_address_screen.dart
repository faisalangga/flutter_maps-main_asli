import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/controller/address_controller.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';
import 'package:koperasimobile/widget/material/button_white_widget.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    AddressController addressControl = Get.put(AddressController());
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Alamat", 
              style: TextConstant.regular.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
        ),
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
              Text('Area Pengirimanmu', style: TextConstant.regular.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alamat sebagai', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 14),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        keyboardType: TextInputType.text,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Alamat",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
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
                    Text('Nama Penerima', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 14),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        keyboardType: TextInputType.emailAddress,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan Nama Penerima",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
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
                    Text('Nomor Telepon Penerima', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.deny(RegExp('[\\-|\\,|\\.|\\#|\\*]'))
                        ],
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "+628123456789",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
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
                    Text('Email Penerima (Opsional)', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan email penerima",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
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
                    Text('Cari Kota / Kec', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Pilih Kota / Kecamatan",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
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
                    Text('Kode Pos', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan Kode Pos",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
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
                    Text('Detail Alamat', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        controller: addressControl.detailAddress,
                        onChanged: (value) {
                          addressControl.getLength();
                        },
                        maxLength: 25,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Tulis nama jalan, nomor rumah, blok, RT/RW",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: 
                            Text(
                              'Tulis detail alamat lengkap dengan jelas', 
                              textAlign: TextAlign.left,
                              style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black45, fontSize: 12),
                            ),
                        ),
                        Expanded(
                          flex: 1,
                          child: 
                            Text(
                              addressControl.lengthDetailAddress.value.toString()+'/150', 
                              textAlign: TextAlign.left,
                              style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black45, fontSize: 12),
                            ),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lokasi (Berdasar pinpoint)', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    SizedBox(height: 10),
                    ButtonWhiteWidget(
                      text: '+ Tambah titik lokasi', 
                      onClick: (){
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pesan (Opsional)', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLength: 25,
                        decoration: DecorationConstant.inputDecor().copyWith(hintText: "Masukkan pesanmu untuk driver",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                      ),
                    )
                  ],
                ),
              ),
              CheckboxListTile(
                title: Text('Jadikan sebagai alamat utama', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 14),),
                value: addressControl.setMainAddress.value,
                onChanged: (newValue) {
                  addressControl.changeSetMainAddress(!addressControl.setMainAddress.value);
                  print(addressControl.setMainAddress.value);
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 35),
              ButtonGreenWidget(
                text: 'Simpan', 
                onClick: (){
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
