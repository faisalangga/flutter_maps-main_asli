import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/constant/utils_rp.dart';
import 'package:koperasimobile/screen/home/landing_home.dart';
import 'package:koperasimobile/utils/Utils.dart';
import 'package:koperasimobile/utils/utils_dialog.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../constant/const_url.dart';
import '../../../constant/image_constant.dart';
import '../../../controller/pengajuan_simp_controller.dart';
import '../../../model/model_jaminan.dart';
import '../../../model/model_tenor.dart';
import '../../../utils/utils_formatnumber.dart';

class AjuSimpInsScreen extends StatefulWidget {
  final String tipeCheck;

  const AjuSimpInsScreen({Key? key, required this.tipeCheck}) : super(key: key);

  @override
  State<AjuSimpInsScreen> createState() => _AjuSimpScreenState();
}

class _AjuSimpScreenState extends State<AjuSimpInsScreen> {
  AjuSimpController ajusimpcontroller = AjuSimpController();

  get edtBulan => ajusimpcontroller.edtbulan;
  Tenor? _company;
  String? _valueCompSelected;
  String? _jasa;
  String? _inibiayadm;
  Jaminan? _jaminan;
  String? _jaminanValueCompSelected;
  String? _duedate;
  String selectedDuration = '3 Bulan';
  String selectednilai = '0.00';
  int? pinjamanValue = 0;
  int? pokok = 0;
  int? bunga = 0;
  int? biayaadm = 0;
  int? jumtot = 0;

  int id = 1;

  // bool _switchValue = true;
  // bool _obscureText = true;

  DateTime newTime = DateTime.now();
  DateTime oldTime = DateTime.now();

  Future<bool> onBackPress() async {
    return await UtilsDialog.onBackPressConfirm(context);
  }

  String? tenor() {
    return _valueCompSelected?.length == 8
        ? _valueCompSelected?.substring(0, 2)
        : _valueCompSelected?.substring(0, 1);
  }

  int mbadmin() {
    String? formattedValue = _inibiayadm;
    if (formattedValue != null && formattedValue.endsWith('.0')) {
      formattedValue = formattedValue.substring(0, formattedValue.length - 2);
    }
    return int.tryParse(formattedValue ?? '') ?? 0;
  }

  int hitungpokokAngsuran() {
    if (_valueCompSelected != null) {
      int lamaAngsuran = int.tryParse(tenor()!) ?? 0;
      if (pinjamanValue != null) {
        return (pinjamanValue! ~/ lamaAngsuran);
      }
    }
    return 0;
  }

  int hitungbunga() {
    if (pinjamanValue != null && _jasa != null) {
      double bunga = double.parse(_jasa!) / 100;
      return (pinjamanValue! * bunga).toInt();
    }
    return 0;
  }

  int viewjml() {
    if (pinjamanValue != null && pinjamanValue! > 0) {
      int pokok = hitungpokokAngsuran();
      int bunga = hitungbunga();
      // int biayaAdmin = biayaadm ?? 0;
      int inibadmin = mbadmin();

      int total = pokok + bunga + inibadmin;
      return total;
    }
    return 0;
  }

  int Sisa() {
    if (pinjamanValue != null && pinjamanValue! > 0) {
      int pokok = int.tryParse('${viewjml()}'!) ?? 0;
      int tnr = int.tryParse(tenor()!) ?? 0;
      int sisa = pokok * tnr;
      return sisa;
    }
    return 0;
  }

  // String? duedate([int? tenorBulan]) {
  //   DateTime hariini = DateTime.now();
  //   DateTime dueDate = hariini.add(Duration(days: tenorBulan! * 30));
  //   return "${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}";
  // }
  //
  // void main() {
  //   print(tenor());
  //   int tenorBulan = (int.tryParse(tenor()!) ?? 0) - 1;
  //   String? jatuhTempo = duedate(tenorBulan);
  //   print("fais Tanggal jatuh tempo: $jatuhTempo");
  // }

  String formatCurrency(int value) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'RP ', decimalDigits: 0);
    return formatter.format(value);
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              // print('faisklikins');
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back, color: Colors.white),
          ),
          centerTitle: true,
          title: Text(
            'Pengajuan Pinjaman',
            style: TextConstant.regular.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nominal Pinjaman',
                        style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                pinjamanValue = 0;
                              } else {
                                pinjamanValue =
                                    int.tryParse(value.replaceAll(',', '')) ?? 0;
                              }
                            });
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ThousandsFormatter(),
                          ],
                          controller: ajusimpcontroller.edtpinjaman,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: 'Nominal Pinjaman',
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
                      )
                    ],
                  ),
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tenor Pinjaman',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    DropdownSearch<Tenor>(
                      popupProps: PopupProps.dialog(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          controller: ajusimpcontroller.edtbulan,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                            suffixIcon: IconButton(
                              icon: Icon(Icons.phonelink_erase_outlined),
                              onPressed: () {
                                ajusimpcontroller.edtbulan.clear();
                              },
                            ),
                          ),
                        ),
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(item.bulan.toString()),
                        ),
                      ),
                      compareFn: (item, _company) =>
                          item.bulan == _company.bulan,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                      onChanged: (data) {
                        setState(() {
                          _company = data;
                          ajusimpcontroller.edtbulan.text =
                              data!.bulan.toString();
                          _valueCompSelected = data.bulan.toString();
                          _jasa = data.nbiayajasa!.toString();
                          _inibiayadm = data.mbiayaadmin!.toString();
                          // print('faisxxxx + $_jasa $_inibiayadm');
                          DateTime hariini = DateTime.now();
                          // print ('fais' + tenor()! ??"0");
                          DateTime dueDate =
                              addMonths(hariini, int.tryParse(tenor()!) ?? 0);
                          // DateTime dueDate = hariini.add(Duration(days: ((int.tryParse(tenor()!) ?? 0) - 1) * 30));
                          _duedate = dueDate.toString();
                          // print('faisaasssss');
                          // print('faisaaa + $_duedate');
                          // print(tenor());
                          // print('fais $_valueCompSelected');
                        });
                      },
                      selectedItem: _company,
                      itemAsString: (Tenor item) => item.bulan.toString(),
                      dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.bulan ??
                              'Pilih Jangka Pinjaman (Bulan)'),
                      asyncItems: (text) async {
                        var requestMap = {"cbranch": "", "nbiayajasa": ""};
                        var response = await http.post(
                          Uri.parse(
                              "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.tenor}"),
                          body: json.encode(requestMap),
                          headers: {"Content-Type": "application/json"},
                        );
                        // print(
                        //     'fais ${ConstUrl.BASE_URL_GOLANG}${ConstUrl.tenor}');
                        List company = (json.decode(response.body)
                            as Map<String, dynamic>)['data'];
                        List<Tenor> modelcompany = [];
                        company.forEach((element) {
                          modelcompany.add(Tenor(
                            cBranch: element['cBranch'],
                            bulan: element['bulan'],
                            nbiayajasa: element['nbiayajasa'],
                            mbiayaadmin: element['mbiayaadmin'],
                          ));
                        });
                        return modelcompany;
                      },
                    ),
                  ],
                )),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keperluan',
                        style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: ajusimpcontroller.edtnote,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: 'Keperluan Pinjaman',
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
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jaminan Pinjaman',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    DropdownSearch<Jaminan>(
                      popupProps: PopupProps.dialog(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          controller: ajusimpcontroller.edtjaminan,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                            suffixIcon: IconButton(
                              icon: Icon(Icons.phonelink_erase_outlined),
                              onPressed: () {
                                ajusimpcontroller.edtjaminan.clear();
                              },
                            ),
                          ),
                        ),
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(item.jaminan.toString()),
                        ),
                      ),
                      compareFn: (item, _jaminan) =>
                          item.jaminan == _jaminan.jaminan,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                      onChanged: (Datajaminan) {
                        setState(() {
                          _jaminan = Datajaminan;
                          ajusimpcontroller.edtjaminan.text =
                              Datajaminan!.jaminan.toString();
                          _jaminanValueCompSelected =
                              Datajaminan.jaminan.toString();
                          // print('fais + $_jaminanValueCompSelected +$_jaminan');
                          // print('fais $_valueCompSelected');
                        });
                      },
                      selectedItem: _jaminan,
                      itemAsString: (Jaminan item) => item.jaminan.toString(),
                      dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.jaminan ?? 'Pilih Jaminan Peminjam'),
                      asyncItems: (text) async {
                        var requestMap = {"cbranch": ""};
                        var response = await http.post(
                          Uri.parse(
                              "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.jaminan}"),
                          body: json.encode(requestMap),
                          headers: {"Content-Type": "application/json"},
                        );
                        // print(
                        //     'fais ${ConstUrl.BASE_URL_GOLANG}${ConstUrl.jaminan}');
                        List jaminancompany = (json.decode(response.body)
                            as Map<String, dynamic>)['data'];
                        List<Jaminan> modeljaminan = [];
                        jaminancompany.forEach((element) {
                          modeljaminan.add(Jaminan(
                            jaminan: element['cjaminan'],
                          ));
                        });
                        return modeljaminan;
                      },
                    ),
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    'INFO TAGIHAN',
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
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Nominal',
                                      style: TextConstant.regular.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text('${rupiah(pinjamanValue.toString())}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Pokok Angsuran',
                                      style: TextConstant.regular.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                      '${rupiah(hitungpokokAngsuran().toString())}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Jasa ${_jasa != null ? '$_jasa' : ''} % (Per Bulan)',
                                      style: TextConstant.regular.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text('${rupiah(hitungbunga().toString())}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  // Text(formatCurrency(
                                  //     pinjamanValue != null && pinjamanValue! > 0
                                  //         ? biayaadm ?? 0
                                  //         : 0)),
                                  Text(
                                      '${pinjamanValue != null && pinjamanValue! > 0 ? rupiah(mbadmin().toString()) : rupiah(0.toString())}'),
                                ],
                              ),
                            ]),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Angsuran (Per Bulan)',
                                style: TextConstant.regular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              '${rupiah(viewjml().toString())}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ButtonGreenWidget(
                  text: 'Simpan',
                  onClick: () async {
                    await showPlatformDialog(
                        context: context,
                        builder: (_) => BasicDialogAlert(
                                title: Text(
                                  'Konfirmasi',
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  BasicDialogAction(
                                      title: Text(
                                        "Batal",
                                        textAlign: TextAlign.left,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // print('fais  ${TextAlign.left}');
                                      }),
                                  BasicDialogAction(
                                      title: Text(
                                        "Ajukan Sekarang",
                                        textAlign: TextAlign.right,
                                      ),
                                      onPressed: () async {
                                        Map<String, dynamic> data = {
                                          // 'bulan': '$_valueCompSelected',
                                          'pinjaman': '$pinjamanValue',
                                          'pokok': '${hitungpokokAngsuran()}',
                                          'bunga': '${hitungbunga()}',
                                          'biayaadmin': '$biayaadm',
                                          'totalAngsuran': '${viewjml()}',
                                          'keperluan':
                                              ajusimpcontroller.edtnote,
                                          'jaminan':
                                              '$_jaminanValueCompSelected',
                                          'tenor': tenor(),
                                          'duedate': '$_duedate',
                                          'sisa' : '${Sisa()}',
                                        };
                                        // print('fais' +
                                        //     ajusimpcontroller.edtjaminan.text);
                                        await ajusimpcontroller.validationSupp(
                                            context: context,
                                            data: data,
                                            callback: (result, error) async {
                                              if (result != null &&
                                                  result['error'] != true) {
                                                Navigator.pop(context);
                                                await showPlatformDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      BasicDialogAlert(
                                                    title: Text(
                                                        'Pengajuan Berhasil',
                                                        textAlign:
                                                            TextAlign.center),
                                                    content: Lottie.asset(
                                                      ImageConstant.berhasil,
                                                      fit: BoxFit.contain,
                                                      height: 150,
                                                      width: 200,
                                                    ),
                                                    actions: <Widget>[
                                                      BasicDialogAction(
                                                        title: Text('Ok',
                                                            textAlign: TextAlign
                                                                .center),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          // print('fais pop 1');
                                                          Navigator.pop(
                                                              context);
                                                          // print('fais pop 2');
                                                          Navigator.pop(
                                                              context);
                                                          // print('fais pop 3');
                                                          Navigator.pop(
                                                              context);
                                                          // print('fais pop 4');
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  // AjuSimpInsScreen(
                                                                  //     tipeCheck:
                                                                  //         ''),
                                                                  LandingHome(),
                                                            ),
                                                          );
                                                          // print('fais pop 5');
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            });
                                      }),
                                ]));
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
