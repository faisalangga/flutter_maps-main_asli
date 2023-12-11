import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/screen/address/list_alamat_screen.dart';

class AlamatWidget extends StatelessWidget {
  const AlamatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Alamat', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w700),),
              GestureDetector(
                onTap: ()=>Get.to(()=>ListAlamatScreen()),
                child: Text('Pilih Alamat lain', style: TextConstant.medium.copyWith(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w700),)),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 10),
            // decoration: DecorationConstant.boxButtonBorder(widthBorder: 1, colorBorder: Colors.grey.shade300, color: Colors.white, radius: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Menara Syahidah', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w700),),
                SizedBox(height: 10),
                Text('Jalan gatot subroto kav 13 no 123', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500),),
                Divider()
              ],
            ),
          )
        ],
      ),
    );
  }
}
