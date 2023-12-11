import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/colors_icon.dart';
import '../../../constant/image_constant.dart';
import '../../auth/isitabungan/isi_tabungan_ins_screen.dart';
import '../../auth/tarik_tunai/tarik_tunai_ins_screen.dart';

class SubMenuTabungan extends StatefulWidget {
  @override
  State<SubMenuTabungan> createState() => _SubMenuTabungan();
}

class _SubMenuTabungan extends State<SubMenuTabungan> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: Text(
            'Sub Menu Tabungan'
        ),
        elevation: 0.5,
        centerTitle: true,
        // automaticallyImplyLeading: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: AppColors.primarycolors,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  Card(
                    color: AppColors.abu,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10), // Radius sudut
                    ),
                    margin: const EdgeInsets.all(5),
                    child: InkWell(
                        onTap: () => Get.to(TarikTunaiInsScreen(tipeCheck:'ini create')),
                        splashColor: Colors.blue,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(ImageConstant.mutasi,height: 50),
                              SizedBox(height: 10),
                              Text("WithDrawal",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        )),
                  ),
                  Card(
                    color: AppColors.abu,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10), // Radius sudut
                    ),
                    margin: const EdgeInsets.all(5),
                    child: InkWell(
                        onTap: () => Get.to(TopUpPage()),
                        splashColor: Colors.blue,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(ImageConstant.rekening,height: 50),
                              SizedBox(height: 10),
                              Text("Deposit",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}