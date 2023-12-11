// ignore_for_file: duplicate_import, unused_import
import 'package:camera/camera.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koperasimobile/constant/const_url.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/controller/sett_role_controller.dart';
import 'package:koperasimobile/model/model_users.dart';
import 'package:koperasimobile/screen/home/view/home_screen.dart';
import 'package:koperasimobile/screen/home/view/landing_screen.dart';

import 'package:koperasimobile/widget/material/button_green_widget.dart';

import '../../../model/model_role.dart';
import '../../../model/model_users.dart';


class SettInsScreen extends StatefulWidget {

  const SettInsScreen({Key? key,}) : super(key: key);

  @override
  State<SettInsScreen> createState() => _SettScreenState();
}

class _SettScreenState extends State<SettInsScreen> {
  SettController settcontroller = SettController();

  set namaUsername(String? namaUsername) {}
  set namaCek(String? namaCek) {}
  String? kodeDivisi;

  Username? _username;
  Data? _kodeDivisi;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.back, color: Colors.black87)),
        title: Text(
          'Menu Setting Role Akses',
          style: TextConstant.regular.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownSearch<Username>(
                          popupProps: PopupProps.dialog(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              controller: settcontroller.edtusr,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    settcontroller.edtusr.clear();
                                  },
                                ),
                              ),
                            ),
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                                  title: Text(item.cusername),
                             ),
                          ),
                          compareFn: (item, _user) =>
                              item.cusername == _user.cusername,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(),
                          ),
                          onChanged: (data) {
                            setState(() {
                              _username = data;
                              settcontroller.edtusr.text = data.toString();
                            });
                          },
                          selectedItem: _username,
                          itemAsString: (item) => item.cusername,
                          dropdownBuilder: (context, selectedItem) => Text(
                              selectedItem?.cusername ??
                                  'Belum pilih Username'),
                          asyncItems: (text) async {
                            var response = await http.get(Uri.parse(
                                "${ConstUrl.BASE_URL}${ConstUrl.User}"));
                            List username = (json.decode(response.body)
                                as Map<String, dynamic>)['data'];
                            List<Username> modelDataUser = [];
                            username.forEach((element) {
                              modelDataUser.add(
                                  Username(cusername: element['username']));
                            });
                            return modelDataUser;
                          },
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Divisi',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownSearch<Data>(
                          popupProps: PopupProps.dialog(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              controller: settcontroller.edtdiv,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    settcontroller.edtdiv.clear();
                                  },
                                ),
                              ),
                            ),
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                                  title: Text('${item.cek}'),
                            ),
                          ),
                          // compareFn: (item, _cek) => item.cek == _cek.ccek,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(),
                          ),
                          onChanged: (data) {
                            setState(() {
                              _kodeDivisi = data;
                              settcontroller.edtdiv.text = '${data?.akses}';
                              kodeDivisi = '${data?.akses}';
                              // print('pais kodeDivisi: $kodeDivisi');
                            });
                          },
                          selectedItem: _kodeDivisi,
                          // enabled: _username != null,
                          itemAsString: (item) => '${item.cek}',
                          dropdownBuilder: (context, selectedItem) =>
                            Text(selectedItem?.cek ?? 'Belum pilih Divisi'),

                          asyncItems: (text) async {
                            var response = await http.get(Uri.parse(
                                "${ConstUrl.BASE_URL}${ConstUrl.Akses}"));
                            List data = (json.decode(response.body)
                            as Map<String, dynamic>)['data'];
                            List<Data> modelCek = [];
                            data.forEach((element) {
                              // print('pais element ${element['cek']}');
                              modelCek.add(Data(akses: element['akses'],cek: element['cek']));
                              // modelCek.add(Cek(ccek: element['cek']));
                            });
                            return modelCek;
                          },
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 35),
              ButtonGreenWidget(
                text: 'Simpan',
                onClick: () => settcontroller.validationSupp(
                  // kodeDivisi: _kodeDivisi,
                    context: context,
                    callback: (result, error) {
                      if (result != null && result['error'] != true) {
                        Get.back();
                        DialogConstant.alertSucces('Pendaftaran Berhasil');
                        setState(() {});
                      }
                      if (error != null) {
                        DialogConstant.alertError('Pendaftaran Gagal, NIK Sudah Terdaftar');
                      }
                    }),
              ),
              // SizedBox(height: 20),
              // Center(
              //   child: GestureDetector(
              //     onTap: ()=>Get.back(),
              //     child: RichText(
              //       text: TextSpan(
              //         text: 'Nomor NIK Sudah Ada ?',
              //         style: TextConstant.regular,
              //         children: <TextSpan>[
              //           TextSpan(text: '', style: TextConstant.regular.copyWith(
              //               color: Colors.orange
              //           )),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
