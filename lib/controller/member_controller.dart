import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/const_url.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:crypto/crypto.dart';

class MemberController extends GetxController {
  RxBool crtPassLogin = true.obs;

  RxInt posPage = 0.obs;
  RxInt posLandingPage = 0.obs;
  bool isKaryawanError = false;
  RxList jsonSample = [].obs;
  RxList checkedAccept = [].obs;
  RxString nomorSo = "".obs;

  // String formattedDate = UtilsDate.tanggalHariIni('yyyy-MM-dd');
  String usrnm = '';

  TextEditingController edtnikK = TextEditingController();
  TextEditingController edtcomp = TextEditingController();
  TextEditingController edtcabang = TextEditingController();
  TextEditingController edtnik = TextEditingController();
  TextEditingController edtpassword = TextEditingController();
  TextEditingController edtnama = TextEditingController();
  TextEditingController edtnamapgl = TextEditingController();
  TextEditingController edtalamat = TextEditingController();
  TextEditingController edtprovktp = TextEditingController();
  TextEditingController edtkotaktp = TextEditingController();
  TextEditingController edtkecktp = TextEditingController();
  TextEditingController edtlurah = TextEditingController();
  TextEditingController edtkdpos = TextEditingController();
  TextEditingController edtalamatdomisli = TextEditingController();
  TextEditingController edtpropinsidomisli = TextEditingController();
  TextEditingController edtkotadomisli = TextEditingController();
  TextEditingController edtkecdomisli = TextEditingController();
  TextEditingController edtlurah1 = TextEditingController();
  TextEditingController edtkdpos2 = TextEditingController();
  TextEditingController edttlp = TextEditingController();
  TextEditingController edttempat = TextEditingController();
  TextEditingController edttgl = TextEditingController();
  TextEditingController edtpekerjaan = TextEditingController();
  TextEditingController edtbank = TextEditingController();
  TextEditingController edtnorek = TextEditingController();
  RxString fotoID = "".obs;
  RxString fotoSelfie = "".obs;

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

    header['Content-Type'] = 'application/json';
    API.basePost(ConstUrl.tampMember, post, header, true, (result, error) {
      if (error != null) {
        jsonSample.value = [
          {
            "No_KTP": "-",
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

  validationSupp(
      {BuildContext? context,
      void callback(result, exception)?,
      required Future<Map<String, dynamic>> value}) async {
    Map<String, dynamic> data = await value;
    // print('fais switchvalue: ${data['switchValue']}');
    // print('fais cbranch: ${data['cbranch']}');
    // print('fais comcode: $edtnama');
    if (data['switchValue'] == true) {
      if (data['compcode'] == null) {
        DialogConstant.alertError('Kode Perusahaan tidak boleh kosong!');
        isKaryawanError = true;
      } else if (data['cbranch'] == null) {
        DialogConstant.alertError('Kantor cabang tidak boleh kosong!');
        isKaryawanError = true;
      } else if (edtnikK.text == '') {
        DialogConstant.alertError('Nik Karyawan tidak boleh kosong!');
        isKaryawanError = true;
      }else{
        isKaryawanError = false;
      }
    }
    if(!isKaryawanError){
      if (edtnamapgl.text == '') {
        DialogConstant.alertError('Username tidak boleh kosong');
      } else if (edtnama.text == '') {
        DialogConstant.alertError('Nama tidak boleh kosong!');
      } else if (data['jenkel'] == null) {
        DialogConstant.alertError('Jenis Kelamin tidak boleh kosong');
      } else if (edttempat.text == '') {
        DialogConstant.alertError('Tempat Lahir tidak boleh kosong');
      } else if (edttgl.text == '') {
        DialogConstant.alertError('Tanggal Lahir tidak boleh kosong');
      } else if (edtnik.text == '') {
        DialogConstant.alertError('NIK tidak boleh kosong!');
      } else if (edtpassword.text == '') {
        DialogConstant.alertError('Password tidak boleh kosong!');
      } else if (edtalamat.text == '') {
        DialogConstant.alertError('Alamat (KTP) tidak boleh kosong!');
      } else if (edtprovktp.text == '') {
        DialogConstant.alertError('Provinsi (KTP) tidak boleh kosong!');
      } else if (edtkotaktp.text == '') {
        DialogConstant.alertError('Kota (KTP) tidak boleh kosong!');
      } else if (edtkecktp.text == '') {
        DialogConstant.alertError('Kecamatan (KTP) tidak boleh kosong!');
      } else if (edtlurah.text == '') {
        DialogConstant.alertError('Kelurahan (KTP) tidak boleh kosong!');
      } else if (edtkdpos.text == '') {
        DialogConstant.alertError('Kode Pos (KTP) tidak boleh kosong!');
      } else if (edtpekerjaan.text == '') {
        DialogConstant.alertError('Pekerjaan tidak boleh kosong!');
      } else if (edtalamatdomisli.text == '') {
        DialogConstant.alertError('Alamat tidak boleh kosong!');
      } else if (edtpropinsidomisli.text == '') {
        DialogConstant.alertError('Provinsi (Domisili) tidak boleh kosong!');
      } else if (edtkotadomisli.text == '') {
        DialogConstant.alertError('Kota (Domisili) tidak boleh kosong!');
      } else if (edtkecdomisli.text == '') {
        DialogConstant.alertError('Kecamatan (Domisili) tidak boleh kosong!');
      } else if (edtlurah1.text == '') {
        DialogConstant.alertError('Kelurahan (Domisili) tidak boleh kosong!');
      } else if (edtkdpos2.text == '') {
        DialogConstant.alertError('Kode Pos (Domisili) tidak boleh kosong!');
      } else if (edttlp.text == '') {
        DialogConstant.alertError('Nomor Telepon tidak boleh kosong!');
      } else if (edtbank.text == '') {
        DialogConstant.alertError('Kode Bank tidak kosong!');
      } else if (edtnorek.text == '') {
        DialogConstant.alertError('Nomor Rekening tidak boleh kosong!');
      } else if (fotoID.value == '') {
        DialogConstant.alertError('ID Card tidak boleh kosong!');
      } else if (fotoSelfie.value == '') {
        DialogConstant.alertError('Foto Wajah tidak boleh kosong!');
      } else {
        postsupp_inp(
            value: value,
            context: context,
            callback: (result, error) => callback!(result, error));
      }
    }

  }

  postsupp_inp(
      {BuildContext? context,
      void callback(result, exception)?,
      required Future<Map<String, dynamic>> value}) async {
    Map<String, dynamic> data = await value;
    // print('fais10  ${data['switchValue']}');
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    header['Content-Type'] = 'application/json';
    post['edtcomp'] = data['compcode'] == null ? "" : data['compcode'];
    post['edtcabang'] = data['cbranch'] == null ? "" : data['cbranch'];
    post['edtnikK'] = edtnikK.text;
    post['edttempat'] = edttempat.text;
    post['edttgl'] = data['inidate'] == null ? "" : data['inidate'];
    post['edtnik'] = edtnik.text;
    post['edtpassword'] = edtpassword.text;
    post['edtnama'] = edtnamapgl.text;
    post['edtalamat'] = edtalamat.text;
    post['edtprovktp'] = edtprovktp.text;
    post['edtkotaktp'] = edtkotaktp.text;
    post['edtkecktp'] = edtkecktp.text;
    post['edtlurah'] = edtlurah.text;
    post['edtkdpos'] = edtkdpos.text;
    post['edtalamatdomisli'] = edtalamatdomisli.text;
    post['edtpropinsidomisli'] = edtpropinsidomisli.text;
    post['edtkotadomisli'] = edtkotadomisli.text;
    post['edtkecdomisli'] = edtkecdomisli.text;
    post['edtlurah1'] = edtlurah1.text;
    post['edtkdpos2'] = edtkdpos2.text;
    post['edttlp'] = edttlp.text;
    post['edtpekerjaan'] = edtpekerjaan.text;
    post['edtcnama'] = edtnama.text;
    post['edtjenkel'] = data['jenkel'] == null ? "" : data['jenkel'];
    post['edtidcard'] = fotoID.value;
    post['edtselfie'] = fotoSelfie.value;
    post['edtbank'] = edtbank.text;
    post['edtnorek'] = edtnorek.text;

    // print('fais "$post"');
    // print('fais ' + post['edtbank']);
    // print('fais ' + post['edtnorek']);
    DialogConstant.loading(context!, 'Memperoses...');

    API.basePostGolang(ConstUrl.insertMember, post, header, true,
        (result, error) {
      Get.back();
      if (error != null) {
        callback!(null, error);
      }
      if (result != null) {
        callback!(result, null);
      }
    });

    // API.basePost(ConstUrl.insMemberphp, post, header, true, (result, error) {
    //     Get.back();
    //     if (error != null) {
    //       callback!(null, error);
    //     }
    //     if (result != null) {
    //       callback!(result, null);
    //     }
    // });
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("username"));
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
