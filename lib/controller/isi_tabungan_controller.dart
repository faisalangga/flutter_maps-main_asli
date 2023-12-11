import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../api/api.dart';
import '../constant/const_url.dart';
import '../constant/dialog_constant.dart';

class TopUpController extends GetxController {
  var selectedAmount = 0.obs;
  var customAmount = ''.obs;

  TextEditingController recomenNominal = TextEditingController();
  RxString edtfotobukti  = "".obs;

  void selectAmount(int amount) {
    selectedAmount.value = amount;
  }

  void setCustomAmount(String amount) {
    customAmount.value = amount;
  }

  validationTabungan(
      {BuildContext? context,
        void callback(result, exception)?,
        required Future<Map<String, dynamic>> value}
      ) async
  {
    Map<String, dynamic> data = await value;
    // print('fais value: ${data['value']}');
    if (data['value'] == '' || data['value'] == null) {
      DialogConstant.alertError('Nominal tidak boleh kosong!');
    } else if (data['poto'] == null) {
      DialogConstant.alertError('Upload Gambar tidak boleh kosong!');
    } else {
      posttabungan_inp(
          value: value,
          context: context,
          callback: (result, error) => callback!(result, error));
    }
  }

  posttabungan_inp(
      {BuildContext? context,
        void callback(data, exception)?,
    required Future<Map<String, dynamic>> value}) async {
    // Map<String, dynamic> data = await value;
    var post = await value;
    var header = new Map<String, String>();
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    header['Content-Type'] = 'application/json';
     DialogConstant.loading(context!, 'Memperoses...');
    // post['value']  = data['value'] == null ? "" : data['value'];
    // post['cinput'] = preferences.getString("username");
    // post['branch'] = preferences.getString("cbranch");
    // post['member'] = preferences.getString("cmember");
    // post['poto']   = data['poto'] == null ? "" : data['poto'];
    // print('fais $post');

    API.basePostGolang(ConstUrl.Inserttabungan, post, header, true,
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