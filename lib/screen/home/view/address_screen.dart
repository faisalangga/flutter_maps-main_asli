import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/screen/home/view/add_address_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Daftar Alamat", 
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
              Row(
                children: [
                  Text('Alamat Pengiriman', style: TextConstant.regular.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),),
                  SizedBox(width: 80),
                GestureDetector(
                  onTap:()=>Get.to(()=>AddAddressScreen()),
                  child: Text('+ Tambah Alamat', style: TextConstant.regular.copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: Color.fromARGB(221, 0, 173, 14)),),
                ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
