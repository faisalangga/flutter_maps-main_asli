import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/utils/local_data.dart';

class HomeController extends GetxController{

  RxInt posPage = 0.obs;
  RxInt posLandingPage = 0.obs;
  
  RxList jsonSample = [].obs;
  RxList checkedAccept = [].obs;
  RxString nomorSo = "".obs;

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
    nomorSo.value = "";

    header['Content-Type'] = 'application/json';
    post['username'] = await LocalData.getData('user');
    API.basePost('/get-accept-so.php', post, header, true, (result, error) {
      if(error != null){
        jsonSample.value = [{"Sales Order#": "-", "Tanggal": "-", "Barang": "-", "Notes": "?", "KG": "0", "Total": "0", "Cek": "?"}];
        callback!(null, error);
      }
      if(result != null){
        jsonSample.value = result['data'] as List;
        callback!(result, null);
      }
    });
  }
  
  validationAcceptJob({BuildContext? context, void callback(result, exception)?}){
    if(checkedAccept == []){
      DialogConstant.alertError('Tidak ada Sales Order yang dipilih!');
    }else{
      acceptJob(
        context: context,
        callback: (result, error)=>callback!(result, error)
      );
    }
  }

  acceptJob({
    BuildContext? context,
    void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();

    header['Content-Type'] = 'application/json';
    post['nobukti'] = checkedAccept;
    await LocalData.getData('user').then((user) {
      post['username'] = user;
    });

    DialogConstant.loading(context!, 'Proses...');

    API.basePost('/accept-so.php', post, header, true, (result, error) {
      Get.back();
      if(error != null){
        callback!(null, error);
      }
      if(result != null){
        checkedAccept.value = [];
        callback!(result, null);
      }
    });
  }
  
}