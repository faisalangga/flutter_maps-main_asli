// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class model_supplier {
  String baseUrl = "http://192.168.100.206";
  // String baseUrl = "http://172.16.2.55";
  /*
    C:\Users\bernoulli\AppData\Local\Android\Sdk\platform-tools>
    .\adb devices
    .\adb tcpip 5555
    .\adb connect 172.16.2.54
  */

  Future<List> select_data_login(String phone, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/tokool/login.php"),
      body: {"phone": phone, "password": password},
    );
    var results2 = json.decode(response.body);
    print(results2);
    return results2.toList();
  }

  Future<List> getUser(String username) async {
    final response = await http.post(
      Uri.parse("$baseUrl/tokool/register.php/getuser"),
      body: {"username": username},
    );
    var results2 = json.decode(response.body);
    return results2.toList();
  }

  Future<bool> insertUser(Map dataInsert) async {
    try {
      final response = await http.post(
        Uri.parse(
            "$baseUrl/tokool/register.php/tambahuser"),
        body: {
          "username": dataInsert['user'].toString(),
          "email": dataInsert['email'].toString(),
          "phone": dataInsert['phone'].toString(),
          "password": dataInsert['pass'].toString(),
        },
      );
      if (response.statusCode >= 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  Future<List> data_supplier(String cari) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 =
    //     await konek.query("select * from $table where namas like '%$cari%' ;");
    // await konek.close();
    // return results2.toList();
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/sup.php/datasup"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2.toList();
  }

  // Future<List> get_data_supplier(String id) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 = await konek.query("select * from $table where id = '$id';");
    // await konek.close();
    // return results2.toList();
  // }
  //
  // Future<List> insert_data_supplier(Map data_insert) async {
  //   var konek = await m_koneksi.koneksi();
  //   var results2 = await konek.query(
  //       'insert into ' +
  //           table +
  //           ' (id,nama,alamat,no_tlp,keterangan) values (?, ?, ?, ?, ?)',
  //       [
  //         data_insert['id'],
  //         data_insert['nama'],
  //         data_insert['alamat'],
  //         data_insert['no_tlp'],
  //         data_insert['keterangan'],
  //       ]);
  //   await konek.close();
  //   return results2.toList();
  // }
  //
  // Future<List> update_data_supplier_by_id(Map data_insert) async {
  //   var konek = await m_koneksi.koneksi();
  //   var results2 = await konek.query("update $table set "
  //       "nama ='${data_insert['nama']}',"
  //       " alamat = '${data_insert['alamat']}',"
  //       " no_tlp = '${data_insert['no_tlp']}',"
  //       " keterangan = '${data_insert['keterangan']}'"
  //       " where id = '${data_insert['id']}'");
  //   await konek.close();
  //   return results2.toList();
  // }
  //
  // Future<List> delete_supplier_byID(String id) async {
  //   var konek = await m_koneksi.koneksi();
  //   var results2 = await konek.query("delete from $table where id = '$id';");
  //   await konek.close();
  //   return results2.toList();
  // }
}


