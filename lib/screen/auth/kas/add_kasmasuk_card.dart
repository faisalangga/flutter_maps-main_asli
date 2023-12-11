// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koperasimobile/config/color.dart';
import 'package:koperasimobile/config/config.dart';
import 'package:koperasimobile/controller/kas_controller.dart';
import 'package:koperasimobile/model/data_account.dart';
import 'package:provider/provider.dart';

Widget AddKasMasukCard(
    BuildContext context, int index, DataAccount data_account) {
  TextEditingController hargaController = new TextEditingController();
  TextEditingController uraianController = new TextEditingController();
  TextEditingController reffController = new TextEditingController();
  uraianController.value = TextEditingValue(
    text: data_account.uraian.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.uraian.toString().length),
    ),
  );
  reffController.value = TextEditingValue(
    text: data_account.reff.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.reff.toString().length),
    ),
  );
  hargaController.value = TextEditingValue(
    text: config().format_rupiah(data_account.jumlah.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset:
              config().format_rupiah(data_account.jumlah.toString()).length),
    ),
  );
  var kasmasukController =
      Provider.of<KasController>(context, listen: false);

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${index + 1}.",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              data_account.acno,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: uraianController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Uraian",
                    hintStyle: GoogleFonts.poppins(
                        color: GreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      kasmasukController.data_account_keranjang[index].uraian =
                          uraianController.text;
                      kasmasukController.hitungSubTotal();
                      // kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_account_keranjang[index].uraian =
                        uraianController.text;
                    kasmasukController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: reffController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Reff",
                    hintStyle: GoogleFonts.poppins(
                        color: GreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      kasmasukController.data_account_keranjang[index].reff =
                          reffController.text;
                      kasmasukController.hitungSubTotal();
                      // kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_account_keranjang[index].reff =
                        reffController.text;
                    kasmasukController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: hargaController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Rp 0",
                    hintStyle: GoogleFonts.poppins(
                        color: GreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      hargaController.value = TextEditingValue(
                        text: config().format_rupiah(hargaController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(hargaController.text)
                                  .length),
                        ),
                      );
                      kasmasukController.data_account_keranjang[index].jumlah =
                          config().convert_rupiah(hargaController.text);
                      // kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_account_keranjang[index].jumlah =
                        config().convert_rupiah(hargaController.text);
                    kasmasukController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              kasmasukController.data_account_keranjang.removeAt(index);
              kasmasukController.hitungSubTotal();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(
                "assets/images/ic_hapus.png",
                height: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
