import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';

class ButtonWhiteWidget extends StatelessWidget {
  String? text;
  Function? onClick;
  ButtonWhiteWidget({Key? key, this.text, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onClick!(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 14),
        decoration: DecorationConstant.boxButtonBorder(radius: 8, color: Colors.grey.shade100, colorBorder: Colors.green, widthBorder: 1),
        child: Center(
          child: Text(text!, style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.green)),
        ),
      ),
    );
  }
}
