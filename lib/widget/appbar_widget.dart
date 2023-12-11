import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/text_constant.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  AppBarWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Text(title!, style: TextConstant.medium.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
