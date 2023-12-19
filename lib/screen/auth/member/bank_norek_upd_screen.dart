import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:koperasimobile/constant/const_url.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/controller/member_controller.dart';
import 'package:koperasimobile/screen/home/view/landing_screen.dart';
import 'package:koperasimobile/utils/utils_dialog.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

import '../../../model/mode_setupbank.dart';
import '../../../utils/utils_formatnumber.dart';

class SuppInsScreen extends StatefulWidget {
  final String tipeCheck;

  const SuppInsScreen({Key? key, required this.tipeCheck}) : super(key: key);

  @override
  State<SuppInsScreen> createState() => _SuppScreenState();
}

class _SuppScreenState extends State<SuppInsScreen> {
  MemberController membercontroller = MemberController();

  DateTime newTime = DateTime.now();
  DateTime oldTime = DateTime.now();

  Future<bool> onBackPress() async {
    return await UtilsDialog.onBackPressConfirm(context);
  }

  set namaCompany(String? namaCompany) {}

  set namaCabang(String? namaCabang) {}

  set namaProvinsi(String? namaProvinsi) {}

  set namaKota(String? namaKota) {}

  set namaKecamatan(String? namaKecamatan) {}

  set namaKodepos(String? namaKodepos) {}

  String? kodepos;
  String? kodepos2;
  String? provinsiSelected;
  String? provinsiSelected2;
  String? kotaselected;
  String? kotaselected2;
  String? kecamatanselected;
  String? kecamatanselected2;
  String? desaselected;
  String? desaselected2;
  String? kodeposselected;
  String? kodeposselected2;

  int id = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
            'Update Data Bank',
            style: TextConstant.regular.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BANK ANDA',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                SizedBox(height: 10),
                DropdownSearch<Data>(
                  popupProps: PopupProps.dialog(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      controller: membercontroller.edtbank,
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
                            membercontroller.edtbank.clear();
                          },
                        ),
                      ),
                    ),
                    itemBuilder: (context, item, isSelected) => ListTile(
                      title: Text(item.cnamabank.toString()),
                    ),
                  ),
                  compareFn: (item, _company) =>
                      item.cnamabank == _company.cnamabank,
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
                      membercontroller.edtbank.text =
                          data!.cnamabank.toString();
                    });
                  },
                  itemAsString: (Data item) => item.cnamabank.toString(),
                  dropdownBuilder: (context, selectedItem) =>
                      Text(selectedItem?.cnamabank ?? 'Pilih Kode Bank'),
                  asyncItems: (text) async {
                    var requestMap = {"": ""};
                    var response = await http.post(
                      Uri.parse(
                          "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.cekdatabank}"),
                      body: json.encode(requestMap),
                      headers: {"Content-Type": "application/json"},
                    );
                    // print('fais ${ConstUrl.BASE_URL_GOLANG}${ConstUrl.cekdatabank}');
                    List company = (json.decode(response.body)
                        as Map<String, dynamic>)['data'];
                    List<Data> modeldtbank = [];
                    company.forEach((element) {
                      modeldtbank.add(Data(
                        cnamabank: element['cnamabank'],
                        ccode: element['ccode'],
                      ));
                    });
                    return modeldtbank;
                  },
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NOMOR REKENING ANDA',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      Container(
                          width: width,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            controller: membercontroller.edtnorek,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.payments_outlined,
                                color: Colors.black,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'Input Nomor Rekening',
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
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ButtonGreenWidget(
                  text: 'Update Data',
                  onClick: () => membercontroller.validationEdit(
                      context: context,
                      callback: (result, error) {
                        if (result != null && result['error'] != true) {
                          Get.back();
                          DialogConstant.alertError('Update Berhasil');
                          Future.delayed(Duration(milliseconds: 1500), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LandingScreen(),
                                ));
                            setState(() {});
                          });
                        }
                        if (error != null) {
                          DialogConstant.alertError(result['pesan']);
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
