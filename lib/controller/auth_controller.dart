import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/const_url.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/utils/local_data.dart';

class AuthController extends GetxController {
  RxBool openPassLogin = true.obs;

  // RxString userName = "".obs;
  TextEditingController edtNama = TextEditingController();
  TextEditingController edtEmail = TextEditingController();
  TextEditingController edtNohp = TextEditingController();
  TextEditingController edtPass = TextEditingController();
  TextEditingController edtConfirmPass = TextEditingController();

  changeOpenPassLogin(bool val) {
    openPassLogin.value = val;
  }

  validation({BuildContext? context, void callback(result, exception)?}) {
    if (edtNohp.text == '') {
      DialogConstant.alertError('No Handpone tidak boleh kosong!');
    } else if (edtPass.text == '') {
      DialogConstant.alertError('Password tidak boleh kosong!');
    } else {
      postLogin(
          context: context,
          callback: (result, error) => callback!(result, error));
    }
  }

  postLogin({
    BuildContext? context,
    void callback(result, exception)?}){
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();

    header['Content-Type'] = 'application/json';
    post['phone'] = edtNohp.text;
    post['password'] = edtPass.text;
    // print('fais post111 $post');
    DialogConstant.loading(context!, 'Memperoses...');
    API.basePostGolang(ConstUrl.login, post, header, true, (result, error) {
    //   API.basePost(ConstUrl.login, post, header, true, (result, error) {

      // print('fais result111 $result');
      Get.back();
      if(error != null){
        // print('fais 3');
        callback!(null, error);
      }
      if(result != null){
        // print('fais 2');
        List dataUser = result['data'];
        LocalData.saveData('user', dataUser[0]['username']);
        LocalData.saveData('email', dataUser[0]['email']);
        LocalData.saveData('phone', dataUser[0]['phone']);
        LocalData.saveData('cNikKaryawan', dataUser[0]['cnikkaryawan']);
        LocalData.saveData('cmember', dataUser[0]['cmember']);
        LocalData.saveData('poto', dataUser[0]['poto']);
        LocalData.saveData('cnmbank', dataUser[0]['cnmbank']);
        LocalData.saveData('cnorek', dataUser[0]['cnorek']);
        LocalData.saveData('badmin', dataUser[0]['badmin']);
        LocalData.saveDataBool('islogin', true);
        setPref(dataUser);
        callback!(result, null);
      }
    });
  }

  setPref(dataUser) async {
    // print('fais  setPrefa');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("cbranch", dataUser[0]['cbranch']);
    preferences.setString("username", dataUser[0]['username']);
    preferences.setString("email", dataUser[0]['email']);
    preferences.setString("phone", dataUser[0]['phone']);
    if (dataUser[0]['cNikKaryawan'] != null) {
      preferences.setString("cNikKaryawan", dataUser[0]['cNikKaryawan']);
    }
    preferences.setString("cmember", dataUser[0]['cmember']);
    preferences.setString("poto", dataUser[0]['poto']);
    preferences.setString("cnmbank", dataUser[0]['cnmbank']);
    preferences.setString("cnorek", dataUser[0]['cnorek']);
    preferences.setString("badmin", dataUser[0]['badmin']);
    preferences.setBool("islogin", true);
  }

  validationRegister(
      {BuildContext? context, void callback(result, exception)?}) {
    if (edtNama.text == '') {
      DialogConstant.alertError('Nama tidak boleh kosong!');
    } else if (edtEmail.text == '') {
      DialogConstant.alertError('Email tidak boleh kosong!');
    } else if (edtNohp.text == '') {
      DialogConstant.alertError('Nomor Telepon tidak boleh kosong!');
    } else if (edtPass.text == '') {
      DialogConstant.alertError('Password tidak boleh kosong!');
    } else if (edtConfirmPass.text == '') {
      DialogConstant.alertError('Konfirmasi Password tidak boleh kosong!');
    } else if (edtPass.text != edtConfirmPass.text) {
      DialogConstant.alertError('Password dan Konfirmasi Password tidak sama!');
    } else {
      postRegister(
          context: context,
          callback: (result, error) => callback!(result, error));
    }
  }

  postRegister({BuildContext? context, void callback(result, exception)?}) {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();

    header['Content-Type'] = 'application/json';
    post['username'] = edtNama.text;
    post['email'] = edtEmail.text;
    post['phone'] = edtNohp.text;
    post['password'] = edtPass.text;

    DialogConstant.loading(context!, 'Memperoses...');
    // print('fais "$post"');
    API.basePost(ConstUrl.insertUser, post, header, true, (result, error) {
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
