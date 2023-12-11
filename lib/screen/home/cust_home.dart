import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/controller/cust_controller.dart';
import 'package:koperasimobile/screen/auth/cust/cust_ins_screen.dart';
import 'package:koperasimobile/screen/home/view/cust_screen.dart';

class CustHome extends StatefulWidget {
  const CustHome({Key? key}) : super(key: key);

  @override
  State<CustHome> createState() => _MainHomeState() ;
}

class _MainHomeState extends State<CustHome> {

  PageController controller = PageController();
  CustController custController = Get.put(CustController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          // physics: BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          children: const <Widget>[
            CustScreen(),
            CustInsScreen(tipeCheck: 'ini create'),
            //SuppEdtScreen(tipeCheck: 'ini edit'),
          ],
          onPageChanged: (val)=>custController.changePage(val),
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
        currentIndex: custController.posPage.value,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        onTap: (val){
          custController.changePage(val);
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
