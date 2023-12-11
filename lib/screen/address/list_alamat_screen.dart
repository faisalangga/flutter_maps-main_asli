import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/screen/address/tambah_alamat.dart';
import 'package:koperasimobile/widget/address/alamat_item.dart';
import 'package:koperasimobile/widget/appbar_widget.dart';

class ListAlamatScreen extends StatelessWidget {
  const ListAlamatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Alamat'),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: ()=>Get.to(()=>TambahAlamatScreen()),
                      child: Text('Tambah Alamat', style: TextConstant.medium.copyWith(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w700),)),
                  Icon(Icons.add, color: Colors.green,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: DecorationConstant.boxButtonBorder(
                        color: Colors.white, radius: 8, colorBorder: Colors.grey.shade300, widthBorder: 1
                      ),
                      child: AlamatItem(
                        onClik: ()=>Get.back(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
