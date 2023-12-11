// ignore_for_file: duplicate_import, unused_import, avoid_web_libraries_in_flutter
import 'dart:convert';

// import 'dart:js';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/controller/pengajuan_simp_controller.dart';
import 'package:koperasimobile/screen/home/pengajuan_simp_home.dart';
import 'package:koperasimobile/screen/home/view/pengajuan_simp_screen.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

import '../../../constant/utils_rp.dart';
import '../../../utils/utils_formatnumber.dart';

class PengajuanEdtScreen extends StatefulWidget {
  final String tipeCheck;
  final String cdocno;
  final String pinjaman;
  final String pokok;
  final String mvalue1;
  final String jasa;
  final String tenor;
  final String badmin;
  final String angsuran;
  final String keperluan;
  final String jaminan;

  const PengajuanEdtScreen({Key? key,
    required this.tipeCheck,
    required this.cdocno,
    required this.pinjaman,
    required this.pokok,
    required this.jasa,
    required this.tenor,
    required this.badmin,
    required this.angsuran,
    required this.keperluan,
    required this.jaminan,
    required this.mvalue1
  })
      : super(key: key);

  @override
  State<PengajuanEdtScreen> createState() => _PengajuanScreenState();
// printInfo(tipeCheck)
}

class _PengajuanScreenState extends State<PengajuanEdtScreen> {
  AjuSimpController ajusimpcontroller = AjuSimpController();

  get cdocno => ajusimpcontroller.edtdocno;

  get tenor => ajusimpcontroller.edttenor;

  get pinjaman => ajusimpcontroller.edtpinjaman;

  get jasa => ajusimpcontroller.edtjasapinjaman;

  get keperluan => ajusimpcontroller.edtnote;

  get jaminan => ajusimpcontroller.edtjaminan;

  get edtEmail => "";

  int? pinjamanValue = 0;

  String rupiah(String amount) {
    final formatter = NumberFormat("#,###,##0");
    return 'Rp. ' + formatter.format(double.parse(amount));
  }

  @override
  void initState() {
    // suppcontroller.edtKodes.text= widget.kodes;
    // suppcontroller.edtNama.text= widget.namas;
    // suppcontroller.edtAlamat.text= widget.alamat;
    // suppcontroller.edtNohp.text= widget.tlp;
    // suppcontroller.edtEmail.text  = widget.email;

    super.initState();
    // print('fais' + widget.tipeCheck);
    // print('fais' + widget.cdocno);
    // print('fais' + widget.tenor);
    // print('fais' + widget.pinjaman);
    // print('fais' + widget.pokok);
    // print('fais' + widget.jasa);
    // print('fais' + widget.badmin);
    // print('fais' + widget.angsuran);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              // print('faisklik');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AjuSimpHome()),
                    (route) => false,
              );
            },
            child: Icon(CupertinoIcons.back, color: Colors.white),
          ),
          centerTitle: true,
          title: Text(
            'Lihat Pengajuan Pinjaman',
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
                        'Nominal Pinjaman ' + widget.cdocno,
                        style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        child: TextField(
                          controller: TextEditingController(
                              text: duet(widget.pinjaman)),
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: rupiah(widget.pinjaman),
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
                SizedBox(height: 10),
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
                      SizedBox(height: 4),
                      Container(
                        child: TextField(
                          controller: TextEditingController(text: widget.tenor +
                              ' Bulan'),
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: widget.pinjaman,
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
                SizedBox(height: 10,),
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
                      SizedBox(height: 4),
                      Container(
                        child: TextField(
                          controller: TextEditingController(
                              text: widget.keperluan),
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: widget.keperluan,
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
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        child: TextField(
                          controller: TextEditingController(
                              text: widget.jaminan),
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: widget.jaminan,
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'INFO TAGIHAN',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Text(
                               rupiah(widget.pinjaman),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Text(rupiah(widget.pokok)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Jasa 1.5 % (Per Bulan)',
                                style: TextConstant.regular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(rupiah(widget.jasa)),
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
                            Text(rupiah(widget.badmin)),
                          ],
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
                              rupiah(widget.angsuran),
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
                SizedBox(height: 35),
                // ButtonGreenWidget(
                //   text: 'Simpan',
                //   onClick: () => ajusimpcontroller.editsupp(
                //       context: context,
                //       callback: (result, error) {
                //         if (result != null && result['error'] != true) {
                //           // Get.back();
                //           // Get.to(SuppScreen());
                //           Get.off(AjuSimpHome());
                //           DialogConstant.alertError('Edit Data Berhasil');
                //         }
                //         if (error != null) {
                //           DialogConstant.alertError('Edit Data Gagal');
                //         }
                //       }),
                // ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
    );
  }
}
