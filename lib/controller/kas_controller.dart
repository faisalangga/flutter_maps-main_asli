
// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/utils/local_data.dart';

import '../model/data_account.dart';
import '../model/model_account.dart';

class KasController extends GetxController{
  RxInt posPage = 0.obs;
  RxInt posLandingPage = 0.obs;

  RxList jsonSample = [].obs;
  RxList jsonKota = [].obs;
  RxList checkedAccept = [].obs;
  RxString nomorSo = "".obs;

  String usrnm='';
  double sumTotal = 0;
  double sumQty = 0;
  //ini header
  TextEditingController edtNbkt   = TextEditingController();
  TextEditingController edtTgl    = TextEditingController();
  TextEditingController edtKet    = TextEditingController();
  TextEditingController edtTotal  = TextEditingController();
  TextEditingController edtBacno  = TextEditingController();
  //inidetail
  TextEditingController edtUraian = TextEditingController();
  TextEditingController edtreff   = TextEditingController();
  TextEditingController edtAcno   = TextEditingController();
  TextEditingController edtNacno  = TextEditingController();
  TextEditingController edtJml    = TextEditingController();

  List<DataAccount> data_account_keranjang = <DataAccount>[];
  List<DataAccount> accountList = <DataAccount>[];

  DateTime chooseDate = DateTime.now();
  final format_tanggal = DateFormat("EEEE, d MMMM yyyy", "id_ID");

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
    API.basePost('/kas.php', post, header, true, (result, error) {
      if(error != null){
        jsonSample.value = [{"NO_BUKTI": "-", "TGL": "-", "KET": "-", "JUMLAH": "?",  "POSTED": "-", "USRNM": "-"}];
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

  validationSupp({BuildContext? context, void callback(result, exception)?}){
    if(edtUraian.text == ''){
      DialogConstant.alertError('Uraian tidak boleh kosong!');
    }else if(edtAcno.text == ''){
      DialogConstant.alertError('No Perk tidak boleh kosong!');
    }else if(edtJml.text == ''){
      DialogConstant.alertError('Jumlah tidak boleh 0,00!');
    }else if(edtKet.text == ''){
      DialogConstant.alertError('Keterangan tidak boleh Kosong!');
    }else{
      postkas_inp(
          context: context,
          callback: (result, error)=>callback!(result, error)
      );
    }
  }

  void hitungSubTotal() {
    sumTotal = 0;
    for (int i = 0; i < data_account_keranjang.length; i++) {
      sumTotal += data_account_keranjang[i].edtjml ?? 0.00;
    }
  }

  void addKeranjang(DataAccount mAccount) {
    data_account_keranjang.add(mAccount);
    sumQty += 1;
    sumTotal += mAccount.jumlah;
    // notifyListeners();
  }

  postkas_inp({BuildContext? context, void callback(result, exception)?}) async
  {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("username"));

    // header['Content-Type'] = 'application/json';
    // post['kodes'] = edtKodes.text;
    // post['namas'] = edtNama.text;
    // post['alamat'] = edtAlamat.text;
    // post['email'] = edtEmail.text;
    // post['tlp'] = edtNohp.text;
    // post['usrnm'] = preferences.getString("username");
    // print(edtAlamat.text);
    // DialogConstant.loading(context!, 'Memperoses...');

    API.basePost('/supp_insert.php', post, header, true, (result, error) {
      Get.back();
      if(error != null){
        callback!(null, error);
      }
      if(result != null){
        callback!(result, null);
      }
    });
  }

  editsupp({BuildContext? context, void callback(result, exception)?}) async
  {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("username"));

    // header['Content-Type'] = 'application/json';
    // post['kodes'] = edtKodes.text;
    // post['namas'] = edtNama.text;
    // post['alamat'] = edtAlamat.text;
    // post['email'] = edtEmail.text;
    // post['tlp'] = edtNohp.text;
    // post['usrnm'] = preferences.getString("username");

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

  @override
  void onInit() async {
    await model_account().data_account(context: null).then((value) {
      print(value);
      if (value != null) {
        accountList.clear();
        for (int i = 0; i < value.length; i++) {
          accountList.add(DataAccount.fromJson(value[i]));
        }
      }
    });
    super.onInit();
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