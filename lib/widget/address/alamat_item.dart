import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/text_constant.dart';

class AlamatItem extends StatelessWidget {
  Function? onClik;
  AlamatItem({Key? key, this.onClik}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onClik!(),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Menara Syahidah', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w700),),
            SizedBox(height: 10),
            Text('Jalan gatot subroto kav 13 no 123', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500),),
          ],
        ),
      ),
    );
  }
}
