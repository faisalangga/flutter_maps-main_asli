// ignore_for_file: duplicate_import, unused_import
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/controller/supp_controller.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

import '../../../config/OnHoverButton.dart';
import '../../../config/color.dart';
import '../../../config/config.dart';
import '../../../controller/kas_controller.dart';
import '../../home/view/kas_screen.dart';

class KasInsScreen extends StatefulWidget {
  final String tipeCheck;
  const KasInsScreen({Key? key, required this.tipeCheck}) : super(key: key);

  @override
  State<KasInsScreen> createState() => _KasScreenState();
  // printInfo(tipeCheck)
}

class _KasScreenState extends State<KasInsScreen> {
  KasController kascontroller = KasController();

  @override
  void initState() {
    super.initState();
    print(widget.tipeCheck);

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KasController>(
        builder: (context, kasmasukController, child) {
          return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: Row(
                children: [
                  Container(
                    height: 25,
                    width: 1,
                    color: AbuColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // Text(
                  //   (widget.tipeCheck) ? 'ini create' : "ini create",
                  //   style: GoogleFonts.poppins(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.black),
                  // ),
                ],
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 20,
                padding: EdgeInsets.all(0),
                icon: Image.asset(
                  "assets/images/ic_back.png",
                  height: 30,
                ),
              ),
              actions: [
                OnHoverButton(
                  child: InkWell(
                    onTap: ()=>kascontroller.validationSupp(
                          context: context,
                          callback: (result, error){
                          if(result != null && result['error'] != true){
                          Get.back();
                          DialogConstant.alertError('Simpan Berhasil');
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>KasScreen(),));
                          setState(() {
                          });
                          }
                          if(error != null){
                          DialogConstant.alertError('Simpan Gagal');
                          }
                          }
                        ),
                       ),
                    ),
                //     child: Container(
                //       height: 30,
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Image.asset(
                //             "assets/images/ic_save.png",
                //             height: 30,
                //           ),
                //           SizedBox(
                //             width: 8,
                //           ),
                //           Text(
                //             "Simpan",
                //             style: GoogleFonts.poppins(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w400,
                //                 color: Colors.black),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24, right: 23, top: 16),
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 24),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "No. Bukti",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: GreyColor),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                          child: TextFormField(
                                            controller: kasmasukController
                                                .edtNbkt,
                                            // readOnly: widget.tipeCheck,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 18, bottom: 18),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              focusedErrorBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 32,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tanggal",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: GreyColor),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                          child: TextFormField(
                                            controller: kasmasukController
                                                .edtTgl,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 18, bottom: 18),
                                              icon: Image.asset(
                                                "assets/images/ic_tanggal.png",
                                                height: 20,
                                              ),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              focusedErrorBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                            onTap: () async {
                                              kasmasukController.chooseDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                      kasmasukController
                                                          .chooseDate,
                                                      lastDate: DateTime(2050),
                                                      firstDate: DateTime(
                                                          DateTime.now()
                                                              .year)) ??
                                                      kasmasukController.chooseDate;
                                              kasmasukController
                                                  .edtTgl.text =
                                                  kasmasukController.format_tanggal
                                                      .format(kasmasukController
                                                      .chooseDate);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 32,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "No. Perk Kas",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: GreyColor),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                          child: TextFormField(
                                            controller:
                                            kasmasukController.edtBacno
                                              ..text = "15.001.001",
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 18, bottom: 18),
                                              icon: Image.asset(
                                                "assets/images/ic_po.png",
                                                height: 20,
                                              ),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              focusedErrorBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                            onTap: () {
                                              // showAnimatedDialog(
                                              //     context,
                                              //     PilihSales(
                                              //         kasmasukController
                                              //                 .salesController
                                              //                 .text
                                              //                 .isEmpty
                                              //             ? null
                                              //             : kasmasukController
                                              //                 .salesController.text,
                                              //         kasmasukController),
                                              //     isFlip: false);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 24, bottom: 24),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dari/Ke",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: GreyColor),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                          child: TextFormField(
                                            controller: kasmasukController
                                                .edtKet,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 18, bottom: 18),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              focusedErrorBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 32,
                                ),
                                Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                    width: 1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 8),
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        // child: searchTextField = AutoCompleteTextField<DataAccount>(
                        //   style: new TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 16.0,
                        //       fontWeight: FontWeight.w600),
                        //   decoration: InputDecoration(
                        //     icon: Image.asset(
                        //       "assets/images/ic_search.png",
                        //       height: 25,
                        //     ),
                        //     fillColor: Colors.white,
                        //     hoverColor: Colors.white,
                        //     contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        //     filled: true,
                        //     hintText: "Cari disini",
                        //     hintStyle: GoogleFonts.poppins(
                        //         color: GreyColor,
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 14),
                        //     border: InputBorder.none,
                        //     focusedBorder: InputBorder.none,
                        //     focusedErrorBorder: InputBorder.none,
                        //     errorBorder: InputBorder.none,
                        //     enabledBorder: InputBorder.none,
                        //     disabledBorder: InputBorder.none,
                        //   ),
                        //   itemSubmitted: (item) {
                        //     DataAccount db_item = DataAccount(
                        //       nama: item.nama,
                        //       noid: item.noid,
                        //       acno: item.acno,
                        //     );
                        //     searchTextField.textField.controller.clear();
                        //     kasmasukController.addKeranjang(db_item);
                        //   },
                        //   submitOnSuggestionTap: true,
                        //   clearOnSubmit: false,
                        //   key: key,
                        //   suggestions: kasmasukController.accountList,
                        //   itemBuilder: (context, item) {
                        //     return Container(
                        //       child: Column(
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.symmetric(
                        //                 horizontal: 16, vertical: 8),
                        //             child: Row(
                        //               children: <Widget>[
                        //                 Expanded(
                        //                   flex: 3,
                        //                   child: Text(
                        //                     item.acno,
                        //                     style: TextStyle(
                        //                         fontSize: 16.0,
                        //                         fontWeight: FontWeight.w500,
                        //                         color: Colors.black87),
                        //                   ),
                        //                 ),
                        //                 Expanded(
                        //                   flex: 5,
                        //                   child: Text(
                        //                     item.nama,
                        //                     style: TextStyle(
                        //                         fontSize: 16.0,
                        //                         fontWeight: FontWeight.w500,
                        //                         color: Colors.black87),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           Divider(
                        //             color: GreyColor,
                        //             height: 1,
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        //   itemSorter: (a, b) {
                        //     return a.nama.compareTo(b.nama);
                        //   },
                        //   itemFilter: (item, query) {
                        //     return item.acno
                        //         .toLowerCase()
                        //         .startsWith(query.toLowerCase());
                        //   },
                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "No.",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Acno",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Uraian",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Referensi",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Jumlah",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          width: 36,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // itemCount: kasmasukController.data_account_keranjang.length,
                      itemBuilder: (BuildContext context, int index) {
                        // return kasScreen(context, index,
                        //     kasmasukController.data_account_keranjang[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(flex: 6, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        text: "Total : ",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                        children: [
                          TextSpan(
                            text: config().format_rupiah(
                                kasmasukController.sumTotal.toString()),
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
