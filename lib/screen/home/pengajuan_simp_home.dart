import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/controller/pengajuan_simp_controller.dart';
import 'package:koperasimobile/screen/home/view/pengajuan_pinj_screen.dart';

class AjuSimpHome extends StatefulWidget {
  const AjuSimpHome({Key? key}) : super(key: key);

  @override
  State<AjuSimpHome> createState() => _MainHomeState() ;
}

class _MainHomeState extends State<AjuSimpHome> {

  PageController controller = PageController();
  AjuSimpController ajusimpController = Get.put(AjuSimpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          // physics: BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          children: const <Widget>[
            // AjuSimpScreen(),
            PinjamanGridWidget(),
            // AjuSimpInsScreen(tipeCheck: 'ini create'),
            //SuppEdtScreen(tipeCheck: 'ini edit'),
          ],
          onPageChanged: (val)=>ajusimpController.changePage(val),
        ),
      ),
    );
  }
}