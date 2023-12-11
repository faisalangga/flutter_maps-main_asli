
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/const_url.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';


class SettController extends GetxController {

  RxBool crtPassLogin = true.obs;

  RxInt posPage = 0.obs;
  RxInt posLandingPage = 0.obs;

  RxList jsonSample = [].obs;
  RxList checkedAccept = [].obs;
  RxString nomorSo = "".obs;

  String usrnm = '';

  TextEditingController edtusr = TextEditingController();
  TextEditingController edtdiv = TextEditingController();


  changeOpenPassikiLogin(bool val){
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

    header['Content-Type'] = 'application/json';
    // post['username'] = await LocalData.getData('user');
    API.basePost('/member.php', post, header, true, (result, error) {
      if (error != null) {
        jsonSample.value = [
          {
            "No_Karyawan": "-",
            "Nama": "-",
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

  validationSupp({BuildContext? context, void callback(result, exception)?}) {
    if (edtusr.text == '') {
      DialogConstant.alertError('Username Belum Dipilih !');
    } else if (edtdiv.text == '') {
      DialogConstant.alertError('Akses belum Dipilih !');
    } else {
          postsupp_inp(
          context: context,
          // kodeDivisi: kodeDivisi,
          callback: (result, error) => callback!(result, error));
    }
  }

   postsupp_inp(
    {BuildContext? context, void callback(result, exception)?,}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    header['Content-Type'] = 'application/json';
    post['edtusr'] = edtusr.text;
    post['edtdiv'] = edtdiv.text;
    // post['edtpassword'] = edtpassword.text;
    // post['edtnama'] = edtnama.text;
    // post['edtalamat'] = edtalamat.text;
    // post['edtprovktp'] = edtprovktp.text;
    // post['edtkotaktp'] = edtkotaktp.text;
    // post['edtkecktp'] = edtkecktp.text;
    // post['edtlurah'] = edtlurah.text;
    // post['edtkdpos'] = edtkdpos.text;
    // post['edtalamatdomisli'] = edtalamatdomisli.text;
    // post['edtpropinsidomisli'] = edtpropinsidomisli.text;
    // post['edtkotadomisli'] = edtkotadomisli.text;
    // post['edtkecdomisli'] = edtkecdomisli.text;
    // post['edtlurah1'] = edtlurah1.text;
    // post['edtkdpos2'] = edtkdpos2.text;
    // post['edttlp'] = edttlp.text;
    // post['edtidcard'] = fotoID.value;
    // post['edtselfie'] = fotoSelfie.value;

    // print('fais "$post"');
    // print(post['edtdiv']);
    // print(kodeDivisi);
    // Get.back();
    DialogConstant.loading(context!, 'Memperoses...');

    API.basePost(ConstUrl.Updtusr, post, header, true, (result, error) {
      // Get.back();
      if (error != null) {
        callback!(null, error);
      }
      if (result != null) {
        callback!(result, null);
      }
    });
  }


  //  postsupp_inp(
  //   {BuildContext? context, void callback(result, exception)?}) async {
  //   var post = new Map<String, dynamic>();
  //   var header = new Map<String, String>();
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   header['Content-Type'] = 'application/json';
  //   post['edtnikK'] = edtnikK.text;
  //   print('faisini ' + edtnikK.text);
  //   post['edtnik'] = edtnik.text;
  //   print('faisini ' + edtnik.text);
  //   post['edtpassword'] = edtpassword.text;
  //   print('faisini ' + edtpassword.text);
  //   post['edtnama'] = edtnama.text;
  //   print('faisini ' + edtnama.text);
  //   post['edtalamat'] = edtalamat.text;
  //   print('faisini ' + edtalamat.text);
  //   post['edtprovktp'] = edtprovktp.text;
  //   print('faisini ' + edtprovktp.text);
  //   post['edtkotaktp'] = edtkotaktp.text;
  //   print('faisini ' + edtkotaktp.text);
  //   post['edtkecktp'] = edtkecktp.text;
  //   print('faisini ' + edtkecktp.text);
  //   post['edtlurah'] = edtlurah.text;
  //   print('faisini ' + edtlurah.text);
  //   post['edtkdpos'] = edtkdpos.text;
  //   print('faisini ' + edtkdpos.text);
  //   post['edtalamatdomisli'] = edtalamatdomisli.text;
  //   print('faisini ' + edtalamatdomisli.text);
  //   post['edtpropinsidomisli'] = edtpropinsidomisli.text;
  //   print('faisini ' + edtpropinsidomisli.text);
  //   post['edtkotadomisli'] = edtkotadomisli.text;
  //   print('faisini ' + edtkotadomisli.text);
  //   post['edtkecdomisli'] = edtkecdomisli.text;
  //   print('faisini ' + edtkecdomisli.text);
  //   post['edtlurah1'] = edtlurah1.text;
  //   print('faisini ' + edtlurah1.text);
  //   post['edtkdpos2'] = edtkdpos2.text;
  //   print('faisini ' + edtkdpos2.text);
  //   post['edttlp'] = edttlp.text;
  //   print('faisini ' + edttlp.text);
  //   post['edtidcard'] = fotoID.value;
  //   print('faisini ' + fotoID.value);
  //   post['edtselfie'] = fotoSelfie.value;
  //   print('faisini ' + fotoSelfie.value);
  //
  //   print('fais "$post"');
  //   DialogConstant.loading(context!, 'Memperoses...');
  //
  //   API.basePost('/member_ins.php', post, header, true, (result, error) {
  //     Get.back();
  //     if (error != null) {
  //       callback!(null, error);
  //     }
  //     if (result != null) {
  //       callback!(result, null);
  //     }
  //   });
  // }

  editsupp({BuildContext? context, void callback(result, exception)?}) async {
  //   var post = new Map<String, dynamic>();
  //   var header = new Map<String, String>();
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   print(preferences.getString("username"));
  //
  //   header['Content-Type'] = 'application/json';
  //   post['kodes'] = edtKodes.text;
  //   post['namas'] = edtNama.text;
  //   post['alamat'] = edtAlamat.text;
  //   post['email'] = edtEmail.text;
  //   post['tlp'] = edtNohp.text;
  //   post['usrnm'] = preferences.getString("username");
  //
  //   DialogConstant.loading(context!, 'Memperoses...');
  //
  //   API.basePost('/supp_edit.php', post, header, true, (result, error) {
  //     Get.back();
  //     if (error != null) {
  //       callback!(null, error);
  //     }
  //     if (result != null) {
  //       callback!(result, null);
  //     }
  //   });
  }

  dropdown_provinsi(
      {required provinsi,
        BuildContext? context,
        void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();

    header['Content-Type'] = 'application/json';
    post['provinsi'] = provinsi;
    DialogConstant.loading(context!, 'Memperoses...');

    API.basePost('/provinsi.php', post, header, true, (result, error) {
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

    API.basePost('/supp_delete.php', post, header, true, (result, error) {
      Get.back();
      if (error != null) {
        callback!(null, error);
      }
      if (result != null) {
        callback!(result, null);
      }
    });
  }

  String generateSHA256Hash(String input) {
    var bytes = utf8.encode(input); // Mengubah string menjadi bytes
    var digest = sha256.convert(bytes); // Menghasilkan hash
    return digest.toString(); // Mengembalikan hash dalam bentuk string
  }
}
