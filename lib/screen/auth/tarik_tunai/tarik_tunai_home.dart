import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/controller/tarik_tunai_controller.dart';
import 'package:koperasimobile/screen/auth/tarik_tunai/tarik_tunai_ins_screen.dart';
import 'package:koperasimobile/screen/home/view/pengajuan_pinj_screen.dart';

class TarikTunaiHome extends StatefulWidget {
  const TarikTunaiHome({Key? key}) : super(key: key);

  @override
  State<TarikTunaiHome> createState() => _MainHomeState() ;
}

class _MainHomeState extends State<TarikTunaiHome> {

  PageController controller = PageController();
  TarikTunai tarikTunaiController = Get.put(TarikTunai());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          // physics: BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          children: const <Widget>[
            PinjamanGridWidget(),
            TarikTunaiInsScreen(tipeCheck: 'ini create'),
          ],
          onPageChanged: (val)=>tarikTunaiController.changePage(val),
        ),
      ),
      // bottomNavigationBar: Obx(()=>BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.youtube_searched_for_outlined),
      //       label: 'Lihat',
      //       backgroundColor: Colors.green,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add_to_photos),
      //       label: 'Create',
      //       backgroundColor: Colors.green,
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(Icons.work_off_outlined),
      //     //   label: 'Delete',
      //     //   backgroundColor: Colors.green,
      //     // ),
      //   ],
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.grey.shade400,
      //   showUnselectedLabels: true,
      //   currentIndex: ajusimpController.posPage.value,
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.green,
      //   onTap: (val){
      //     ajusimpController.changePage(val);
      //     controller.animateToPage(val, duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
      //   },
      //   // onTap: _onItemTapped,
      // )),
    );
  }
}
