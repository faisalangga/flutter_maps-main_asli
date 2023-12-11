import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/screen/home/view/sub_menu_tabungan.dart';

import '../../../constant/colors_icon.dart';
import '../../../constant/image_constant.dart';

class SubMenuSaldo extends StatefulWidget {
  @override
  State<SubMenuSaldo> createState() => _SubMenuSaldo();
}

class _SubMenuSaldo extends State<SubMenuSaldo> {

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
            'Sub Menu Saldo'
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
                        // onTap: () => Get.to(TopUpPage()),
                          onTap: () => Get.to(SubMenuSaldo()),
                          splashColor: Colors.blue,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                               Image.asset(ImageConstant.simpokok,height: 50),
                                SizedBox(height: 10),
                                Text("Simpanan Pokok",
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
                        // onTap: () => Get.to(TopUpPage()),
                          onTap: () => Get.to(SubMenuSaldo()),
                          splashColor: Colors.blue,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(ImageConstant.simpwajib,height: 50),
                                SizedBox(height: 10),
                                Text("Simpanan Wajib",
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
                        BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () => Get.to(SubMenuTabungan()),
                          splashColor: Colors.blue,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(ImageConstant.tabungan,height: 50),
                                SizedBox(height: 10),
                                Text("Tabungan",
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