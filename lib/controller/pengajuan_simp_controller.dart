import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/const_url.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';

class AjuSimpController extends GetxController {
  RxBool crtPassLogin = true.obs;
  RxInt posPage = 0.obs;
  RxInt posLandingPage = 0.obs;
  RxList jsonSample = [].obs;
  RxList checkedAccept = [].obs;
  RxString nomorSo = "".obs;
  String usrnm = "";

  TextEditingController edtpinjaman = TextEditingController();
  TextEditingController edtbulan = TextEditingController();
  TextEditingController edtpokok = TextEditingController();
  TextEditingController edtbunga = TextEditingController();
  TextEditingController edtbiayaadm = TextEditingController();
  TextEditingController edtdocno = TextEditingController();
  TextEditingController edtvalue = TextEditingController();
  TextEditingController edtnilaipinjaman = TextEditingController();
  TextEditingController edtjasapinjaman = TextEditingController();
  TextEditingController edtbadmin = TextEditingController();
  TextEditingController edttenor = TextEditingController();
  TextEditingController edtnote = TextEditingController();
  TextEditingController edtjaminan = TextEditingController();

  changeOpenPassikiLogin(bool val) {
    crtPassLogin.value = val;
  }

  changeLandingPage(int val) {
    posLandingPage.value = val;
  }

  changePage(int val) {
    posPage.value = val;
  }

  getSO({BuildContext? context, void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    nomorSo.value = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    header['Content-Type'] = 'application/json';
    var requestMap = {"input": preferences.getString("username")};

    post.addAll(requestMap);

    API.basePostGolang(ConstUrl.viewpinjaman, post, header, true,
        (result, error) {
      if (error != null) {
        jsonSample.value = [
          {
            "cdocno": "",
            "tgl": "",
            "tenor": "",
            "pinjaman": "",
            "angsuran": "",
            "jasa": "",
            "cStatus": "",
            "cnote": "",
            "cjaminan": "",
          }
        ];
        callback!(null, error);
      }
      if (result != null) {
        jsonSample.value = result['data'] as List;
        callback!(result, null);
      }
    });
  }

  validationSupp(
      {BuildContext? context,
      void callback(result, exception)?,
      dynamic data}) async {
    // print('pais '+  data['bulan']);
    if (edtpinjaman.text == '') {
      DialogConstant.alertError('Nominal tidak boleh kosong!');
      // } else if (data['bulan'] == null) {
      //   DialogConstant.alertError('bulan tidak boleh kosong!');
    } else if (edtnote.text == '') {
      DialogConstant.alertError('Keperluan tidak boleh kosong!');
    } else if (edtjaminan.text == '') {
      DialogConstant.alertError('Jaminan harus Diisi!');
    } else {
      // print('pais view11 $data');
      postsupp_inp(
          data: data,
          context: context,
          callback: (result, error) => callback!(result, error));
    }
  }

  postsupp_inp(
      {BuildContext? context,
      void callback(data, exception)?,
      required data}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    header['Content-Type'] = 'application/json';
    // print('pais data ${data['pinjaman']}');
    // print('pais data ${data['pokok']}');
    // print('pais data ${data['bunga']}');
    // print('pais data ${data['biayaadmin']}');
    // print('pais data ${data['totalAngsuran']}');
    // print('pais data ${preferences.getString("username")}');

    DialogConstant.loading(context!, 'Memperoses...');

    post['bulan'] = data['tenor'];
    post['pinjaman'] = data['pinjaman'];
    post['pokok'] = data['pokok'];
    post['bunga'] = data['bunga'];
    post['biayaadmin'] = data['biayaadmin'];
    post['totalAngsuran'] = data['totalAngsuran'];
    post['cbranch'] = preferences.getString("cbranch");
    post['cmember'] = preferences.getString("cmember");
    post['cinput'] = preferences.getString("username");
    post['keperluan'] = edtnote.text;
    post['jaminan'] = data['jaminan'];
    post['duedate'] = data['duedate'];
    print('fais $post');

    API.basePostGolang(ConstUrl.insertPinjaman, post, header, true,
        (result, error) {
      Get.back();
      if (error != null) {
        // print('fais tidak error');
        // print('fais error1 $error');
        callback!(null, error);
      }
      if (result != null) {
        // print('fais result');
        // print('fais result1 $result');
        callback!(result, null);
      }
    });
  }

  editsupp(
      {BuildContext? context,
      void callback(result, exception)?,
      required data}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("username"));

    header['Content-Type'] = 'application/json';
    post['cdocno'] = data['cdocno'];
    // post['usrnm'] = preferences.getString("username");

    DialogConstant.loading(context!, 'Memperoses...');

    API.basePostGolang(ConstUrl.editpinjaman, post, header, true,
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

  hps_supp(
      {required kodes,
      BuildContext? context,
      void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    print(kodes);

    header['Content-Type'] = 'application/json';
    post['kodes'] = kodes;
    DialogConstant.loading(context!, 'Memperoses...');

    // API.basePost('/supp_delete.php', post, header, true, (result, error) {
    //   Get.back();
    //   if (error != null) {
    //     callback!(null, error);
    //   }
    //   if (result != null) {
    //     callback!(result, null);
    //   }
    // });
  }
}
