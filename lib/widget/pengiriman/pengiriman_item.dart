import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';

class PengirimanItem extends StatelessWidget {
  const PengirimanItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Get.back(),
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 10),
        decoration: DecorationConstant.boxButtonBorder(
            color: Colors.white, radius: 8, colorBorder: Colors.grey.shade300, widthBorder: 1
        ),
        child: Row(
          children: [
            Icon(Icons.delivery_dining, size: 40,),
            SizedBox(width: 10),
            Text('JNE', style: TextConstant.regular.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text('Rp10.000', style: TextConstant.regular,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
