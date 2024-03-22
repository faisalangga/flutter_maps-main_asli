import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/utils/utils_dialog.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/api.dart';
import '../../../constant/const_url.dart';
import '../../../constant/dialog_constant.dart';
import '../../../constant/image_constant.dart';
import '../../../constant/utils_rp.dart';
import '../../../controller/tarik_tunai_controller.dart';
import '../../../model/model_landingpage.dart';
import '../../../utils/utils_formatnumber.dart';
import '../../../widget/tabungan/App_recomen_nominal.dart';
import '../../home/landing_home.dart';
import '../member/bank_norek_upd_screen.dart';

class TarikTunaiInsScreen extends StatefulWidget {
  final String tipeCheck;

  const TarikTunaiInsScreen({Key? key, required this.tipeCheck})
      : super(key: key);

  @override
  State<TarikTunaiInsScreen> createState() => _TartunScreenState();
}

class _TartunScreenState extends State<TarikTunaiInsScreen> {
  TarikTunai tariktunaicontroller = TarikTunai();

  String? saldosimpString;
  String? nabank;
  String? norek;
  String? badmin;
  String? recomenNominal = '';
  String? recomenNominalxx = '';
  double totalPenarikan = 0.0;
  DateTime newTime = DateTime.now();
  DateTime oldTime = DateTime.now();

  Future<bool> onBackPress() async {
    return await UtilsDialog.onBackPressConfirm(context);
  }

  Future<String?> getdatabankusr() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? namabank = preferences.getString("cnmbank");
    return namabank;
  }

  Future<String?> getdatanorek() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? norek = preferences.getString("cnorek");
    return norek;
  }

  Future<String?> getdatabiayaadm() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? badmin = preferences.getString("badmin");
    return badmin;
  }

  Future<String> fetchSaldo() async {
    Completer<String> completer = Completer<String>();
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? ccustcode = preferences.getString("cmember");
      String? branch = preferences.getString("cbranch");
      String? nama = preferences.getString("user")?.substring(0, 4)?.replaceAll('.', '');
      Map<String, dynamic> post = {
        "ccustcode": "$ccustcode",
        "branch": "$branch",
        "nama": "$nama"
      };
      API.basePostGolang(ConstUrl.ceksaldo2, post, header, true,
          (result, error) {
        if (error != null) {
          // print(' fais Error fetching saldo inipais: $error');
          completer.complete('0');
        }
        if (result != null) {
          setState(() {
            try {
              LandingpageModel response = LandingpageModel.fromJson(result);
              saldosimpString = response.data![0].saldosimp!;
            } catch (e) {
              print('$e');
            }
          });
          // print('inipaisxxx: $saldosimpString');
          completer.complete(saldosimpString);
        }
      });
    } catch (error) {
      print('fais Error fetching saldo : $error');
      completer.complete('0');
    }
    return completer.future;
  }

  void _updateTotalPenarikan() {
    double nominal = recomenNominalxx != null && recomenNominalxx!.isNotEmpty
        ? double.tryParse(recomenNominalxx!.replaceAll(',', '')) ?? 0.0
        : 0.0;
    // print('fais12 $recomenNominalxx');
    // print('fais12222 $nominal');

    double biayaAdmin = badmin != null && badmin!.isNotEmpty
        ? double.tryParse(badmin!.replaceAll(',', '')) ?? 0.0
        : 0.0;
    // print('fais123 $badmin');
    // print('fais122345 $biayaAdmin');

    setState(() {
      totalPenarikan = nominal + biayaAdmin;
      // print('fais1234 $totalPenarikan');
    });
  }

  @override
  void initState() {
    super.initState();
    tariktunaicontroller.recomenNominal.addListener(_updateRecomenNominal);
    _updateRecomenNominal();
    _loadUserData();
    _loadNorekData();
    _loadDataBiayaadm();
    _updateTotalPenarikan();
    fetchSaldo().then((value) {
      setState(() {});
    });
  }

  _loadUserData() async {
    var dataBankUser = await getdatabankusr();
    if (dataBankUser != null) {
      setState(() {
        nabank = dataBankUser;
      });
    }
  }

  _loadNorekData() async {
    var databiayaadmin = await getdatanorek();
    if (databiayaadmin != null) {
      setState(() {
        norek = databiayaadmin;
      });
    }
  }

  _loadDataBiayaadm() async {
    var dataNorekUser = await getdatabiayaadm();
    if (dataNorekUser != null) {
      setState(() {
        badmin = dataNorekUser;
      });
    }
  }

  void _updateRecomenNominal() {
    setState(() {
      final textFieldValue = tariktunaicontroller.recomenNominal.text;
      recomenNominal =
          textFieldValue.isNotEmpty ? textFieldValue.replaceAll(',', '') : '';
      recomenNominalxx = textFieldValue.isNotEmpty ? textFieldValue : null;
      _updateTotalPenarikan();
    });
  }

  bool isExpanded = false;
  // bool showUpdateButton = false;

  bool _showUpdateButton() {
    return '$nabank' == '-' ||
        '$norek' == '-' ||
        '$nabank' == null ||
        '$norek' == null;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    // print('fais showUpdateButton:$showUpdateButton');
    double saldosimp = saldosimpString != null
        ? double.tryParse(saldosimpString!) ?? 0.0
        : 0.0;
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back, color: Colors.black),
          ),
          centerTitle: true,
          title: Text(
            'With Drawal',
            style: TextConstant.regular.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black87,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Saldo Anda ',
                                    style: TextConstant.medium.copyWith(
                                      color: Colors.black45,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Rp. ${saldosimpString != null && double.tryParse(saldosimpString!) != null ? duet(saldosimpString!) : '0'}',
                                // 'Rp. ${saldosimpString != null && double.tryParse(saldosimpString!) != 0 ? duet(saldosimpString!) : '0'}',
                                style: TextConstant.medium.copyWith(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Lottie.asset(
                    ImageConstant.tarikijo,
                    fit: BoxFit.contain,
                    height: 80,
                    width: width,
                  ),
                ),
                Text(
                  'REKENING ANDA',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                SizedBox(height: 10),
                Container(
                  width: width,
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ThousandsFormatter(),
                        ],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        controller: TextEditingController(
                            text: ('$nabank ($norek)' != null &&
                                    '$nabank' != '-' &&
                                    '$norek' != '-' &&
                                    '$nabank' != null &&
                                    '$norek' != null)
                                ? '$nabank ($norek)'
                                : ''),
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_box_outlined,
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: ('$nabank || $norek' != null &&
                                  '$nabank' != '-' &&
                                  '$norek' != '-' &&
                                  '$nabank' != null &&
                                  '$norek' != null)
                              ? '$nabank || $norek'
                              : '',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: (_showUpdateButton())
                              ? IconButton(
                                  icon: Icon(Icons.warning, color: Colors.red),
                                    onPressed: () {
                                    Get.to(SuppInsScreen(
                                    tipeCheck: 'edit',
                                    ));
                                  },
                                )
                              : null,
                        ),
                      ),
                      // Container(
                      //   height: 15,
                      //   child: Visibility(
                      //     visible: showUpdateButton,
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         SizedBox(height: 5,),
                      //         Text(
                      //           'Lengkapi Data Bank dan Nomor Rekening Anda  ',
                      //           style: TextStyle(
                      //             color: Colors.redAccent,
                      //             fontSize: size.height * 0.015,
                      //           ),
                      //         ),
                      //         Icon(
                      //           Icons.info_outline,
                      //           color: Colors.red,
                      //           size: height*0.020,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Text(
                  'PILIH JUMLAH',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                SizedBox(height: 10),
                GridView.count(
                  // primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 4,
                  children: [
                    AppRecomenNominalTarik(
                        image: ImageConstant.receh,
                        nominal: 'Rp.50.000',
                        onTap: () {
                          setState(() {
                            tariktunaicontroller.recomenNominal.text = '50,000';
                            recomenNominal = '50000';
                            recomenNominalxx = '50,000';
                            _updateRecomenNominal();
                          });
                        }),
                    AppRecomenNominalTarik(
                        image: ImageConstant.uangkertas,
                        nominal: 'Rp.500.000',
                        onTap: () {
                          setState(() {
                            tariktunaicontroller.recomenNominal.text =
                                '500,000';
                            recomenNominal = '500000';
                            recomenNominalxx = '500,000';
                            _updateRecomenNominal();
                          });
                        }),
                    AppRecomenNominalTarik(
                        image: ImageConstant.uangkertasaja,
                        nominal: 'Rp.1.000.000',
                        onTap: () {
                          setState(() {
                            tariktunaicontroller.recomenNominal.text =
                                '1,000,000';
                            recomenNominal = '1000000';
                            recomenNominalxx = '1,000,000';
                            _updateRecomenNominal();
                          });
                        }),
                    AppRecomenNominalTarik(
                        image: ImageConstant.uangkertasbanyak,
                        nominal: 'Rp.2.500.000',
                        onTap: () {
                          setState(() {
                            tariktunaicontroller.recomenNominal.text =
                                '2,500,000';
                            recomenNominal = '2500000';
                            recomenNominalxx = '2,500,000';
                            _updateRecomenNominal();
                          });
                        }),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'NOMINAL PENARIKAN',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                SizedBox(height: 10),
                Container(
                  width: width,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ThousandsFormatter(),
                    ],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    controller: tariktunaicontroller.recomenNominal,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.payments_outlined,
                        color: Colors.black,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: recomenNominalxx != null
                          ? recomenNominalxx
                          : 'Ketik Nominal',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Setiap penarikan, Anda dikenai biaya admin sebesar ${badmin != null ? rupiah(badmin.toString()) : rupiah(0.toString())} ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.014,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.info_outline,
                      color: Colors.red,
                      size: size.height * 0.015,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'INFO PENARIKAN',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.swipe_up : Icons.swipe_down,
                        color: Colors.grey,
                        size: 19,
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 700),
                  opacity: isExpanded ? 1.0 : 0.0,
                  child: Visibility(
                    visible: isExpanded,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Nominal Penarikan',
                                style: TextConstant.regular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(rupiah(
                                '${recomenNominal != "" ? recomenNominal : 0.0}')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Biaya Admin',
                                style: TextConstant.regular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                                '${recomenNominal != null && double.tryParse(recomenNominal!) != null && double.tryParse(recomenNominal!)! > 0 ? rupiah(badmin!) : 'Rp. 0'}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Jumlah Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      '${recomenNominal != null && double.tryParse(recomenNominal!) != null && double.tryParse(recomenNominal!)! > 0 ? rupiah(totalPenarikan.toString()) : 'Rp. 0'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ButtonGreenWidget(
                  text: 'Lanjut',
                  onClick: () {
                    if (nabank! == null ||
                        nabank! == '-' && norek! == null ||
                        norek! == '-') {
                      DialogConstant.alertError('Rekening Kosong !!');
                      return;
                    }
                    if (recomenNominal! == null || recomenNominal! == '') {
                      DialogConstant.alertError('Nominal tidak boleh kosong');
                      return;
                    } else {
                      int nominalInt = int.tryParse(recomenNominal!) ?? 0;
                      if (nominalInt % 50000 != 0) {
                        DialogConstant.alertError(
                            'Nominal harus kelipatan dari 50.000');
                        return;
                      }
                      if (saldosimp <= double.tryParse(recomenNominal!)!) {
                        DialogConstant.alertError('Saldo Anda Kurang !!');
                        return;
                      } else {
                        // print('fais1 klik');
                        showPlatformDialog(
                          context: context,
                          builder: (context) {
                            return BasicDialogAlert(
                              title: Center(
                                child: Text(
                                  "Tarik Sekarang",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              content: Lottie.asset(
                                ImageConstant.berhasil,
                                fit: BoxFit.contain,
                                height: 150,
                                width: 200,
                              ),
                              actions: <Widget>[
                                BasicDialogAction(
                                  title:
                                      Text('Oke', textAlign: TextAlign.right),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    Map<String, dynamic> data = {
                                      'saldo': duet(saldosimpString!),
                                      'totawal': '$recomenNominal',
                                      'biayaadmin': '$badmin',
                                      'totalTarikan': totalPenarikan.toString(),
                                    };
                                    await (badmin) != null
                                        ? tariktunaicontroller
                                            .validationTarikTunai(
                                                context: context,
                                                data: data,
                                                callback:
                                                    (result, error) async {
                                                  if (result != null &&
                                                      result['error'] != true) {
                                                    // print('fais1 $result');
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    // print('fais1 last');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            LandingHome(),
                                                      ),
                                                    );
                                                  }
                                                })
                                        : DialogConstant.loading(context!,
                                            'Jaringan Ke Server Bermasalah...');
                                  },
                                ),
                                BasicDialogAction(
                                  title: Text("Batal",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.red,
                                      )),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // print('Batal');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
