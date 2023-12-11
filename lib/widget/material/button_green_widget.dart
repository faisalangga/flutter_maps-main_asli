import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';

class ButtonGreenWidget extends StatelessWidget {
  String? text;
  Function? onClick;
  ButtonGreenWidget({Key? key, this.text, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onClick!(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 14),
        decoration: DecorationConstant.boxButton(radius: 20, color: Colors.green),
        child: Center(
          child: Text(text!, style: TextConstant.regular.copyWith(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
