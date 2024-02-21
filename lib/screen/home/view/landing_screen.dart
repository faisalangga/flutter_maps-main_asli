import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/colors_icon.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/constant/utils_rp.dart';
import 'package:koperasimobile/model/model_landingpage.dart';
import 'package:koperasimobile/screen/home/view/report/Report_Pinjaman_Global_Screen.dart';
import 'package:koperasimobile/screen/home/view/report/Report_Pinjaman_Screen.dart';
import 'package:koperasimobile/screen/home/view/report/Report_Simpanan_Global_Screen.dart';
import 'package:koperasimobile/screen/home/view/report/Report_Simpanan_Screen.dart';
import 'package:koperasimobile/screen/home/view/sub_menu_saldo.dart';
import 'package:koperasimobile/widget/app_shimmer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/api.dart';
import '../../../constant/const_url.dart';
import '../../../constant/image_constant.dart';
import '../pengajuan_simp_home.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  String? pinjamanString = '';
  String? simpananString = '';
  String? saldopnjString = '0';
  String? saldosimpString = '0';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSaldo().then((value) {
      setState(() {
        simpananString = saldosimpString;
        pinjamanString = saldopnjString;
        // print("fais simpananString $simpananString");
        // print("fais pinjamanString $pinjamanString");
        if (simpananString != "" && pinjamanString != "") {
          isLoading = false;
        }
        // print('fais saldos atas : $simpananString');
        // print('fais saldop atas : $pinjamanString');
      });
    });
  }

  Future<String> fetchSaldo() async {
    Completer<String> completer = Completer<String>();
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? ccustcode = preferences.getString("cmember");
      String? branch = preferences.getString("cbranch");
      String? nama = preferences.getString("user")?.substring(0, 4);
      Map<String, dynamic> post = {
        "ccustcode": "$ccustcode",
        "branch": "$branch",
        "nama": "$nama"
      };
      API.basePostGolang(ConstUrl.ceksaldo2, post, header, true,
          (result, error) {
        // if (error != null) {
        //   print('Error fetching saldo inifais: $error');
        //   completer.complete('0');
        // }
        if (result != null) {
          setState(() {
            try {
              LandingpageModel response = LandingpageModel.fromJson(result);
              saldopnjString = response.data![0].saldopinj!;
              saldosimpString = response.data![0].saldosimp!;
              // print(' fais bawah saldopnjString ${saldopnjString}');
              // print(' fais bawah saldosimpString ${saldosimpString}');
            } catch (e) {
              print('$e');
            }
          });
          completer.complete(saldopnjString);
          completer.complete(saldosimpString);
        }
      });
    } catch (error) {
      print('Error fetching saldo : $error');
      completer.complete('0');
    }
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    Future<Uint8List?> getImageBytes() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? base64Image = prefs.getString('poto');
      if (base64Image != null && base64Image.isNotEmpty) {
        return base64Decode(base64Image);
      }
      return null;
    }

    Future<void> _handleRefresh() async {
      try {
        setState(() {
          pinjamanString = "0";
          simpananString = "0";
        });
        await Future.delayed(Duration(milliseconds: 500));
        fetchSaldo().then((value) {
          setState(() {
            simpananString = saldosimpString ?? '0';
            pinjamanString = saldopnjString ?? '0';
            // print('fais saldos : $simpananString');
            // print('fais saldop : $pinjamanString');
          });
        });
      } catch (e) {
        print('fais e $e');
      }
    }

    var size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(ImageConstant.cart_logo,
                  height: size.height * 0.050),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Koperasi',
                  style: TextConstant.medium.copyWith(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sukses Prima Sejahtera',
                  style: TextConstant.medium.copyWith(
                    color: Colors.black87,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // InkWell(
                  //   onTap: () => Get.to(ProfileScreen()),
                  //   child: Row(
                  //     children: [
                  //       FutureBuilder<Uint8List?>(
                  //         future: getImageBytes(),
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             return CircularProgressIndicator();
                  //           } else if (snapshot.hasError) {
                  //             return Text('Error: ${snapshot.error}');
                  //           } else if (snapshot.hasData &&
                  //               snapshot.data != null) {
                  //             return ClipOval(
                  //               child: Image.memory(
                  //                 snapshot.data!,
                  //                 height: 40,
                  //                 width: 40,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             );
                  //           } else {
                  //             return SizedBox.shrink();
                  //           }
                  //         },
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
        elevation: 0.5,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: LiquidPullToRefresh(
          onRefresh: _handleRefresh,
          color: Colors.green.shade400,
          springAnimationDurationInMilliseconds: 5,
          showChildOpacityTransition: false,
          child: Stack(
            // body: Stack(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    child: SizedBox(
                      width: width,
                      height: 220,
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.grey.shade200,
                          color: Colors.transparent,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Lottie.asset(
                                ImageConstant.working,
                                fit: BoxFit.contain,
                                height: 200,
                                width: width,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primarycolors,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.count(
                                  // primary: false,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 4,
                                  children: <Widget>[
                                    Card(
                                      color: AppColors.abu,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.all(5),
                                      child: InkWell(
                                        onTap: () => Get.to(SubMenuSaldo()),
                                        splashColor: Colors.blue,
                                        child: Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(ImageConstant.duet,
                                                  height: size.height * 0.06),
                                              SizedBox(height: 10),
                                              Text("Saldo Simpanan",
                                                  style: TextStyle(
                                                      fontSize: 8.9,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: AppColors.abu,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.all(5),
                                      child: InkWell(
                                          onTap: () => Get.to(AjuSimpHome()),
                                          splashColor: Colors.blue,
                                          child: Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                    ImageConstant.pinjaman,
                                                    height: size.height * 0.06),
                                                SizedBox(height: 10),
                                                Text("Pinjaman",
                                                    style: TextStyle(
                                                        fontSize: 8.9,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          )),
                                    ),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                    Visibility(visible: false, child: Card()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width,
                height: height,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 190,
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.all(0.0),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primarycolors,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.25,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // InkWell(
                                    //   onTap: () async {
                                    //     SharedPreferences prefs =
                                    //         await SharedPreferences
                                    //             .getInstance();
                                    //     var custcode =
                                    //         prefs.getString('cmember');
                                    //     var branch = prefs.getString('cbranch');
                                    //     var nama = prefs
                                    //         .getString('user')
                                    //         ?.substring(0, 4);
                                    //     var nmlgkp = prefs.getString('user');
                                    //
                                    //     showDialog(
                                    //       context: context,
                                    //       builder: (BuildContext context) {
                                    //         return AlertDialog(
                                    //           title: Text('Pilih Jenis Laporan',
                                    //               style: TextStyle(
                                    //                   fontSize: 18,
                                    //                   fontWeight:
                                    //                       FontWeight.bold)),
                                    //           content: Column(
                                    //             mainAxisSize: MainAxisSize.min,
                                    //             children: [
                                    //               ListTile(
                                    //                 title: Text('Report Detail',
                                    //                     style: TextStyle(
                                    //                         fontSize: 13,
                                    //                         fontWeight:
                                    //                             FontWeight
                                    //                                 .bold)),
                                    //                 onTap: () {
                                    //                   Navigator.pop(context);
                                    //                   Navigator.push(
                                    //                     context,
                                    //                     MaterialPageRoute(
                                    //                       builder: (context) =>
                                    //                           ReportScreen(
                                    //                         ccustcode: custcode
                                    //                             .toString(),
                                    //                         branch: branch
                                    //                             .toString(),
                                    //                         nama:
                                    //                             nama.toString(),
                                    //                         nmlengkap: nmlgkp
                                    //                             .toString(),
                                    //                       ),
                                    //                     ),
                                    //                   );
                                    //                 },
                                    //               ),
                                    //               ListTile(
                                    //                 title: Text('Report Global',
                                    //                     style: TextStyle(
                                    //                         fontSize: 13,
                                    //                         fontWeight:
                                    //                             FontWeight
                                    //                                 .bold)),
                                    //                 onTap: () {
                                    //                   Navigator.pop(context);
                                    //                   Navigator.push(
                                    //                     context,
                                    //                     MaterialPageRoute(
                                    //                       builder: (context) =>
                                    //                           ReportGlobalScreen(
                                    //                         ccustcode: custcode
                                    //                             .toString(),
                                    //                         branch: branch
                                    //                             .toString(),
                                    //                         nama:
                                    //                             nama.toString(),
                                    //                         nmlengkap: nmlgkp
                                    //                             .toString(),
                                    //                       ),
                                    //                     ),
                                    //                   );
                                    //                 },
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         );
                                    //       },
                                    //     );
                                    //   },
                                    //   child: Container(
                                    //     padding: EdgeInsets.all(10),
                                    //     child: Column(
                                    //       children: [
                                    //         Text(
                                    //           'Saldo Pinjaman ',
                                    //           style: TextStyle(
                                    //             color: Colors.black,
                                    //             fontSize: 12.0,
                                    //           ),
                                    //         ),
                                    //         isLoading == false
                                    //             ? Text(
                                    //                 'Rp. ${duet(pinjamanString!)}',
                                    //                 style: TextStyle(
                                    //                   color: Colors.black,
                                    //                   fontSize: 15.0,
                                    //                 ),
                                    //               )
                                    //             : AppShimmer(
                                    //                 width: width * 0.25)
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    InkWell(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                        await SharedPreferences
                                            .getInstance();
                                        var custcode =
                                        prefs.getString('cmember');
                                        var branch = prefs.getString('cbranch');
                                        var nama = prefs
                                            .getString('user')
                                            ?.substring(0, 4);
                                        var nmlgkp = prefs.getString('user');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReportScreen(
                                              ccustcode: custcode.toString(),
                                              branch: branch.toString(),
                                              nama: nama.toString(),
                                              nmlengkap: nmlgkp.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Saldo Pinjaman ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            isLoading == false
                                                ? Text(
                                              'Rp. ${duet(pinjamanString!)}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                              ),
                                            )
                                                : AppShimmer(
                                                width: width * 0.25)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                    // InkWell(
                                    //   onTap: () async {
                                    //     SharedPreferences prefs =
                                    //         await SharedPreferences
                                    //             .getInstance();
                                    //     var custcode =
                                    //         prefs.getString('cmember');
                                    //     var branch = prefs.getString('cbranch');
                                    //     var nama = prefs
                                    //         .getString('user')
                                    //         ?.substring(0, 4);
                                    //     var nmlgkp = prefs.getString('user');
                                    //
                                    //     showDialog(
                                    //       context: context,
                                    //       builder: (BuildContext context) {
                                    //         return AlertDialog(
                                    //           title: Text('Pilih Jenis Laporan',
                                    //               style: TextStyle(
                                    //                   fontSize: 18,
                                    //                   fontWeight:
                                    //                   FontWeight.bold)),
                                    //           content: Column(
                                    //             mainAxisSize: MainAxisSize.min,
                                    //             children: [
                                    //               ListTile(
                                    //                 title: Text('Report Detail',
                                    //                     style: TextStyle(
                                    //                         fontSize: 13,
                                    //                         fontWeight:
                                    //                         FontWeight
                                    //                             .bold)),
                                    //                 onTap: () {
                                    //                   Navigator.pop(context);
                                    //                   Navigator.push(
                                    //                     context,
                                    //                     MaterialPageRoute(
                                    //                       builder: (context) =>
                                    //                           ReportSimpScreen(
                                    //                             ccustcode: custcode
                                    //                                 .toString(),
                                    //                             branch: branch
                                    //                                 .toString(),
                                    //                             nama:
                                    //                             nama.toString(),
                                    //                             nmlengkap: nmlgkp
                                    //                                 .toString(),
                                    //                           ),
                                    //                     ),
                                    //                   );
                                    //                 },
                                    //               ),
                                    //               ListTile(
                                    //                 title: Text('Report Global',
                                    //                     style: TextStyle(
                                    //                         fontSize: 13,
                                    //                         fontWeight:
                                    //                         FontWeight
                                    //                             .bold)),
                                    //                 onTap: () {
                                    //                   Navigator.pop(context);
                                    //                   Navigator.push(
                                    //                     context,
                                    //                     MaterialPageRoute(
                                    //                       builder: (context) =>
                                    //                           ReportSimpGlobalScreen(
                                    //                             ccustcode: custcode
                                    //                                 .toString(),
                                    //                             branch: branch
                                    //                                 .toString(),
                                    //                             nama:
                                    //                             nama.toString(),
                                    //                             nmlengkap: nmlgkp
                                    //                                 .toString(),
                                    //                           ),
                                    //                     ),
                                    //                   );
                                    //                 },
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         );
                                    //       },
                                    //     );
                                    //   },
                                    //   child: Container(
                                    //     padding: EdgeInsets.all(10),
                                    //     child: Column(
                                    //       children: [
                                    //         Text(
                                    //           'Saldo Simpanan',
                                    //           style: TextStyle(
                                    //             color: Colors.black,
                                    //             fontSize: 12.0,
                                    //           ),
                                    //         ),
                                    //         isLoading == false
                                    //             ? Text(
                                    //                 'Rp. ${duet(simpananString!)}',
                                    //                 style: TextStyle(
                                    //                   color: Colors.black,
                                    //                   fontSize: 15.0,
                                    //                 ),
                                    //               )
                                    //             : AppShimmer(
                                    //                 width: width * 0.25),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    InkWell(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                        await SharedPreferences
                                            .getInstance();
                                        var custcode =
                                        prefs.getString('cmember');
                                        var branch = prefs.getString('cbranch');
                                        var nama = prefs
                                            .getString('user')
                                            ?.substring(0, 4);
                                        var nmlgkp = prefs.getString('user');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReportSimpScreen(
                                              ccustcode: custcode.toString(),
                                              branch: branch.toString(),
                                              nama: nama.toString(),
                                              nmlengkap: nmlgkp.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Saldo Simpanan ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            isLoading == false
                                                ? Text(
                                              'Rp. ${duet(simpananString!)}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                              ),
                                            )
                                                : AppShimmer(
                                                width: width * 0.25)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
