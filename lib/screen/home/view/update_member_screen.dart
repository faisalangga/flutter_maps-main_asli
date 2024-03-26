import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/screen/auth/member/bank_norek_upd_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/dialog_constant.dart';

class UpdMemberScreen extends StatefulWidget {
  const UpdMemberScreen({Key? key}) : super(key: key);

  @override
  State<UpdMemberScreen> createState() => _UpdMemberScreenState();
}

class _UpdMemberScreenState extends State<UpdMemberScreen> {

  Future<String?> getdtmbr() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? cmember = preferences.getString("cmember");
    return cmember;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting Account"),
          centerTitle: true,
          backgroundColor: Colors.green,
          // automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.accessibility_outlined),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          // var memberID = await getdtmbr();
                          // Get.to(SuppUpdScreen(
                          //   tipeCheck: 'edit',
                          //   memberID: '$memberID',
                          // ));
                          DialogConstant.alertError('Tunggu Update Selanjutnya...');
                        },
                        child: Row(
                          children: [
                            Text("Update Member"),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_right),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    SuppInsScreen(
                      tipeCheck: 'edit',
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.money_outlined),
                      SizedBox(width: 10),
                      InkWell(
                          onTap: () {
                            Get.to(SuppInsScreen(
                              tipeCheck: 'edit',
                            ));
                          },
                          child: Row(
                            children: [
                              Text("Update Data Bank"),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_right),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
