import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/const_url.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';

class TarikTunai extends GetxController {
  RxBool crtPassLogin = true.obs;
  RxInt posPage = 0.obs;
  RxInt posLandingPage = 0.obs;
  RxList jsonSample = [].obs;
  String usrnm = "";

  TextEditingController recomenNominal = TextEditingController();
  TextEditingController edtbankcode = TextEditingController();
  TextEditingController edtnorek = TextEditingController();

  changePage(int val) {
    posPage.value = val;
  }

  validationTarikTunai(
      {BuildContext? context,
      void callback(result, exception)?,
      dynamic data}) async {
    // print('pais111 ' + data['saldo']);
    // print('pais121 ' + data['totawal']);
    // print('pais131 ' + data['biayaadmin']);
    // print('pais141 ' + data['totalTarikan']);
    if (data['saldo'] == '') {
      DialogConstant.alertError('Saldo Minim! tidak bisa transaksi');
    } else if (data['totawal'] == '') {
      DialogConstant.alertError('Nilai penarikan masih kosong');
    } else if (data['totalTarikan'] == '') {
      DialogConstant.alertError('Nilai penarikan masih kosong');
    } else {
      posttariktunai_inp(
          data: data,
          context: context,
          callback: (result, error) => callback!(result, error));
    }
  }

  posttariktunai_inp(
      {BuildContext? context,
      void callback(data, exception)?,
      required data}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    header['Content-Type'] = 'application/json';
    // print('pais11 ' + data['saldo']);
    // print('pais12 ' + data['totawal']);
    // print('pais13 ' + data['biayaadmin']);
    // print('pais14 ' + data['totalTarikan']);

    DialogConstant.loading(context!, 'Memperoses...');
    post['saldolalu'] = data['saldo'];
    post['totawal'] = data['totawal'];
    post['badmin'] = data['biayaadmin'];
    post['value'] = data['totalTarikan'];
    post['branch'] = preferences.getString("cbranch");
    post['member'] = preferences.getString("cmember");
    post['cinput'] = preferences.getString("username");
    // print('fais $post');

    API.basePostGolang(ConstUrl.insertTTunai, post, header, true,
        (result, error) {
      Get.back();
      if (error != null) {
        callback!(null, error);
      }
      if (result != null) {
        callback!(result, null);
      }
    });
  }
}
