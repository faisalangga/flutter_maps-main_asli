// ignore_for_file: duplicate_import, unused_import
import 'dart:math';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:flutter/cupertino.dart';
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
import '../../../model/data_account.dart';
import '../../home/view/kas_screen.dart';
import 'add_kasmasuk_card.dart';

class KasInsScreen extends StatefulWidget {
  final String tipeCheck;
  const KasInsScreen({Key? key, required this.tipeCheck}) : super(key: key);

  @override
  State<KasInsScreen> createState() => _KasScreenState();
  // printInfo(tipeCheck)
}

class _KasScreenState extends State<KasInsScreen> {
  KasController kascontroller = KasController();
  GlobalKey<AutoCompleteTextFieldState<DataAccount>> key = new GlobalKey();
  late AutoCompleteTextField searchTextField;

  @override
  void initState() {
    super.initState();
    print(widget.tipeCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        leading: GestureDetector(
            onTap: ()=>Get.back(),
            child: Icon(CupertinoIcons.back, color: Colors.black87)
        ),
        title: Text('Input Kas Masuk'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 24, right: 23, top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "No. Bukti",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 32,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    height: 25,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: GreyColor),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    child: TextFormField(
                                      controller: kascontroller
                                          .edtNbkt,
                                      // readOnly: widget.tipeCheck,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 15, bottom: 10),
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
                            width: 3,
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
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 32,
                                  ),
                                  Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        height: 25,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: GreyColor),
                                          borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 8),
                                    child: TextFormField(
                                      controller: kascontroller
                                          .edtTgl,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 15, bottom: 10),
                                        // icon: Image.asset(ImageConstant.cart_tgl, height: size.height * 0.010),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        kascontroller.chooseDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate:
                                                kascontroller
                                                    .chooseDate,
                                                lastDate: DateTime(2050),
                                                firstDate: DateTime(
                                                    DateTime.now()
                                                        .year)) ??
                                                kascontroller.chooseDate;
                                        kascontroller
                                            .edtTgl.text =
                                            kascontroller.format_tanggal
                                                .format(kascontroller
                                                .chooseDate);
                                        print(kascontroller.edtTgl);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 27, right: 27, top: 0, bottom: 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dari/Ke",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    height: 25,
                                    width: 1000,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: GreyColor),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    child: TextFormField(
                                      controller: kascontroller
                                          .edtNbkt,
                                      // readOnly: widget.tipeCheck,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 15, bottom: 10),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 32,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
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
            // Padding(
            //   padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
            //   child: Card(
            //     color: Colors.white,
            //     elevation: 3,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Container(
            //       height: 45,
            //       padding: EdgeInsets.symmetric(horizontal: 16),
            //       child: searchTextField = AutoCompleteTextField<DataAccount>(
            //         style: new TextStyle(
            //             color: Colors.black,
            //             fontSize: 16.0,
            //             fontWeight: FontWeight.w600),
            //         decoration: InputDecoration(
            //           icon: Image.asset(
            //             "assets/images/ic_search.png",
            //             height: 25,
            //           ),
            //           fillColor: Colors.white,
            //           hoverColor: Colors.white,
            //           contentPadding:
            //           EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //           filled: true,
            //           hintText: "Cari disini",
            //           hintStyle: GoogleFonts.poppins(
            //               color: GreyColor,
            //               fontWeight: FontWeight.w400,
            //               fontSize: 14),
            //           border: InputBorder.none,
            //           focusedBorder: InputBorder.none,
            //           focusedErrorBorder: InputBorder.none,
            //           errorBorder: InputBorder.none,
            //           enabledBorder: InputBorder.none,
            //           disabledBorder: InputBorder.none,
            //         ),
            //         itemSubmitted: (item) {
            //           print('XXXX');
            //           // var jml = 0;
            //           // DataAccount? dbItem = (DataAccount(
            //           //   nama: item.nama,
            //           //   noid: item.noid,
            //           //   acno: item.acno,
            //           //   uraian: '',
            //           //   reff: '',
            //           //   jumlah: jml.toDouble(),
            //           // )??"") as DataAccount?;
            //           // searchTextField.textField?.controller?.clear();
            //           // kascontroller.addKeranjang(dbItem!);
            //           // print(dbItem!);
            //         },
            //         submitOnSuggestionTap: true,
            //         clearOnSubmit: false,
            //         key: key,
            //         suggestions: kascontroller.accountList,
            //         itemBuilder: (context, item) {
            //           return Container(
            //             child: Column(
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.symmetric(
            //                       horizontal: 16, vertical: 8),
            //                   child: Row(
            //                     children: <Widget>[
            //                       Expanded(
            //                         flex: 3,
            //                         child: Text(
            //                           item.acno,
            //                           style: TextStyle(
            //                               fontSize: 16.0,
            //                               fontWeight: FontWeight.w500,
            //                               color: Colors.black87),
            //                         ),
            //                       ),
            //                       Expanded(
            //                         flex: 5,
            //                         child: Text(
            //                           item.nama,
            //                           style: TextStyle(
            //                               fontSize: 16.0,
            //                               fontWeight: FontWeight.w500,
            //                               color: Colors.black87),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Divider(
            //                   color: GreyColor,
            //                   height: 1,
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //         itemSorter: (a, b) {
            //           return a.nama.compareTo(b.nama);
            //         },
            //         itemFilter: (item, query) {
            //           return item.acno
            //               .toLowerCase()
            //               .startsWith(query.toLowerCase());
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 8),
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Acno",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Uraian",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Reff",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Jumlah",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
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
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 8),
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          maxLength: 50,
                          controller: null,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(hintText: "",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          maxLength: 50,
                          controller: kascontroller.edtAcno,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(hintText: "No.Perk",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                          maxLength: 50,
                          controller: kascontroller.edtUraian,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(hintText: "",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          maxLength: 50,
                          controller: kascontroller.edtreff,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(hintText: "",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          maxLength: 50,
                          controller: kascontroller.edtJml,
                          keyboardType: TextInputType.number,
                          decoration: DecorationConstant.inputDecor().copyWith(hintText: "0,00",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      ),
                      SizedBox(
                        width: 36,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: kascontroller.data_account_keranjang.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return AddKasMasukCard(context, index,
            //           kascontroller.data_account_keranjang[index]);
            //     },
            //   ),
            // ),
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
                          kascontroller.edtTotal.toString()),
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
  }
}
