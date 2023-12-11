// ignore_for_file: avoid_print, deprecated_member_use, prefer_collection_literals

import 'dart:convert';
import 'package:flutter/services.dart';

class DataAccount {
  int noid;
  String acno;
  String nama;
  String uraian;
  String reff;
  double jumlah;

  DataAccount({
    required this.noid,
    required this.acno,
    required this.nama,
    required this.uraian,
    required this.reff,
    required this.jumlah,
  });

  factory DataAccount.fromJson(var parsedJson) {
    return DataAccount(
      noid: parsedJson['no_id'],
      acno: parsedJson['acno'] as String,
      nama: parsedJson['nama'] as String,
      uraian: parsedJson['URAIAN'] as String,
      reff: parsedJson['REFF'] as String,
      jumlah: parsedJson['JUMLAH'],
    );
  }

  get edtjml => null;
}

class AccountViewModel {
  static List<DataAccount> accountList = [];
  static Future loadAccount() async {
    try {
      accountList = <DataAccount>[];
      String jsonString =
          await rootBundle.loadString('assets/file/account.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['account'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        accountList.add(DataAccount.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
