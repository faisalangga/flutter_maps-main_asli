// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../api/api.dart';
import '../constant/dialog_constant.dart';

class model_account {
  static String table = 'account';
  // koneksi_mysql m_koneksi = koneksi_mysql();

  // Future<List> data_account() async {
  //   var konek = await m_koneksi.koneksi();
  //   var results2 = await konek.query('select * from ' + table);
  //   await konek.close();
  //   return results2.toList();
  // }

  data_account({required BuildContext? context, void callback(result, exception)?}) async
  {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    // print(kodes);

    header['Content-Type'] = 'application/json';
    // post['kodes'] = kodes;
    DialogConstant.loading(context!, 'Memperoses...');

    API.basePost('/account.php', post, header, true, (result, error) {
      Get.back();
      if(error != null){
        callback!(null, error);
      }
      if(result != null){
        callback!(result, null);
      }
    });
  }

}
