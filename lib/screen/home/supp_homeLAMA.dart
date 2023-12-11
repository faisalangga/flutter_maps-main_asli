import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/controller/member_controller.dart';
import 'package:koperasimobile/screen/home/view/supp_screen.dart';
import 'package:koperasimobile/screen/auth/member/supp_ins_screen.dart';


class SuppHome extends StatefulWidget {
  const SuppHome({Key? key}) : super(key: key);

  @override
  State<SuppHome> createState() => _MainHomeState() ;
}

class _MainHomeState extends State<SuppHome> {

  PageController controller = PageController();
  MemberController memberController = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          // physics: BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          children: const <Widget>[
            SuppScreen(),
            SuppInsScreen(tipeCheck: 'ini create'),
            //SuppEdtScreen(tipeCheck: 'ini edit'),
          ],
          onPageChanged: (val)=>memberController.changePage(val),
        ),
      ),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.youtube_searched_for_outlined),
            label: 'Lihat',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_photos),
            label: 'Create',
            backgroundColor: Colors.green,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.work_off_outlined),
          //   label: 'Delete',
          //   backgroundColor: Colors.green,
          // ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade500,
        showUnselectedLabels: true,
        currentIndex: memberController.posPage.value,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        onTap: (val){
          memberController.changePage(val);
          controller.animateToPage(val, duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
        },
        // onTap: _onItemTapped,
      )),
    );
  }
}
