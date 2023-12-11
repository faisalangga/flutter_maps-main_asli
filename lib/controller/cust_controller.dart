// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/utils/local_data.dart';

class CustController extends GetxController{
  RxInt posPage = 0.obs;
  RxInt posLandingPage = 0.obs;

  RxList jsonSample = [].obs;
  RxList jsonKota = [].obs;
  RxList checkedAccept = [].obs;
  RxString nomorSo = "".obs;

  String usrnm='';

  TextEditingController edtKodes = TextEditingController();
  TextEditingController edtNama = TextEditingController();
  TextEditingController edtEmail = TextEditingController();
  TextEditingController edtNohp = TextEditingController();
  TextEditingController edtAlamat = TextEditingController();

  changeLandingPage(int val){
    posLandingPage.value = val;
  }

  changePage(int val){
    posPage.value = val;
  }

  getSO({
    BuildContext? context,
    void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    // nomorSo.value = "";

    header['Content-Type'] = 'application/json';
    post['username'] = await LocalData.getData('user');
    API.basePost('/cust.php', post, header, true, (result, error) {
      if(error != null){
        jsonSample.value = [{"Kode_Supp#": "-", "Nama_Supp": "-", "Alamat": "-", "Kota": "-", "Golongan": "-",  "Telp": "-", "UserInput": "-"}];
        callback!(null, error);
        print(jsonSample);
      }
      if(result != null){
        jsonSample.value = result['data'] as List;
        print(jsonSample);
        callback!(result, null);
      }
    });
  }


  getKota({
    BuildContext? context,
    void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    // nomorSo.value = "";

    header['Content-Type'] = 'application/json';
    post['username'] = await LocalData.getData('user');
    API.basePost('/kota.php', post, header, true, (result, error) {
      if(error != null){
        jsonKota.value = [{"Kota": "-"}];
        callback!(null, error);
        print(jsonKota);
      }
      if(result != null){
        jsonKota.value = result['data'] as List;
        print(jsonKota);
        callback!(result, null);
      }
    });
  }

  validationSupp({BuildContext? context, void callback(result, exception)?}){
    // if(edtNama.text == ''){
    //   DialogConstant.alertError('Nama tidak boleh kosong!');
    // }else if(edtEmail.text == ''){
    //   DialogConstant.alertError('Email tidak boleh kosong!');
    // }else if(edtNohp.text == ''){
    //   DialogConstant.alertError('Nomor Telepon tidak boleh kosong!');
    // }else if(edtKodes.text == ''){
    //   DialogConstant.alertError('Kode Supp tidak boleh kosong!');
    // }else if(edtAlamat.text == ''){
    //   DialogConstant.alertError('Alamat tidak boleh kosong!');
    // }else{
      postsupp_inp(
          context: context,
          callback: (result, error)=>callback!(result, error)
      );
    // }
  }
  postsupp_inp({BuildContext? context, void callback(result, exception)?}) async
  {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("username"));

    header['Content-Type'] = 'application/json';
    post['kodes'] = edtKodes.text;
    post['namas'] = edtNama.text;
    post['alamat'] = edtAlamat.text;
    post['email'] = edtEmail.text;
    post['tlp'] = edtNohp.text;
    post['usrnm'] = preferences.getString("username");
    print(edtAlamat.text);
    DialogConstant.loading(context!, 'Memperoses...');

    // API.basePost('/supp_insert.php', post, header, true, (result, error) {
    //   Get.back();
    //   if(error != null){
    //     callback!(null, error);
    //   }
    //   if(result != null){
    //     callback!(result, null);
    //   }
    // });
  }
  editsupp({BuildContext? context, void callback(result, exception)?}) async
  {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("username"));

    header['Content-Type'] = 'application/json';
    post['kodes'] = edtKodes.text;
    post['namas'] = edtNama.text;
    post['alamat'] = edtAlamat.text;
    post['email'] = edtEmail.text;
    post['tlp'] = edtNohp.text;
    post['usrnm'] = preferences.getString("username");

    DialogConstant.loading(context!, 'Memperoses...');

    API.basePost('/supp_edit.php', post, header, true, (result, error) {
      Get.back();
      if(error != null){
        callback!(null, error);
      }
      if(result != null){
        callback!(result, null);
      }
    });
  }

  hps_supp({required kodes,BuildContext? context, void callback(result, exception)?}) async
  {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    print(kodes);

    header['Content-Type'] = 'application/json';
    post['kodes'] = kodes;
    DialogConstant.loading(context!, 'Memperoses...');

    API.basePost('/supp_delete.php', post, header, true, (result, error) {
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