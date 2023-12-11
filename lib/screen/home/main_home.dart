import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/controller/home_controller.dart';
import 'package:koperasimobile/screen/home/view/home_screen.dart';
import 'package:koperasimobile/screen/srg/checkinout_screen';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  PageController controller = PageController();
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          // physics: BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          children: const <Widget>[
            HomeScreen(),
            CheckinoutScreen(tipeCheck: "In",),
            CheckinoutScreen(tipeCheck: "Out",),
          ],
          onPageChanged: (val)=>homeController.changePage(val),
        ),
      ),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Accept Job',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_history_outlined),
            label: 'Check In',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_off_outlined),
            label: 'Check Out',
            backgroundColor: Colors.green,
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade500,
        showUnselectedLabels: true,
        currentIndex: homeController.posPage.value,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        onTap: (val){
          homeController.changePage(val);
          controller.animateToPage(val, duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
        },
        // onTap: _onItemTapped,
      )),
    );
  }
}
