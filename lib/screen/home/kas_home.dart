import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/controller/kas_controller.dart';
import 'package:koperasimobile/screen/home/view/kas_screen.dart';
import 'package:koperasimobile/screen/auth/kas/kas_ins_screen.dart';

class KasHome extends StatefulWidget {
  const KasHome({Key? key}) : super(key: key);

  @override
  State<KasHome> createState() => _MainHomeState() ;
}

class _MainHomeState extends State<KasHome> {

  PageController controller = PageController();
  KasController kasController = Get.put(KasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          // physics: BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          children: const <Widget>[
            KasScreen(),
            KasInsScreen(tipeCheck: 'ini create'),
            //SuppEdtScreen(tipeCheck: 'ini edit'),
          ],
          onPageChanged: (val)=>kasController.changePage(val),
        ),
      ),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Lihat',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_history_outlined),
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
        currentIndex: kasController.posPage.value,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        onTap: (val){
          kasController.changePage(val);
          controller.animateToPage(val, duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
        },
        // onTap: _onItemTapped,
      )),
    );
  }
  // class MyApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //     return MaterialApp(
  //             home: Scaffold(
  //             body: DoubleBackToCloseApp(
  //               child: Home_Screen(),
  //               snackBar: const SnackBar(
  //               content: Text('Tap back again to leave'),
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  // }

  // late DateTime currentBackPressTime;
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //   // body: WillPopScope(child: getBody(), onWillPop: onWillPop),
  //   );
  // }
  //
  // Future<bool> onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     Fluttertoast.showToast(msg:'Exit To Apps');
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }
}
