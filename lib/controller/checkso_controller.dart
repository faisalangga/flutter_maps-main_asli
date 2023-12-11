
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/utils/local_data.dart';

class ChecksoController extends GetxController{
  RxString tipe = "".obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;
  RxString fotocheck = "".obs;
  RxString ttdcheck = "".obs;

  TextEditingController nomorSo = TextEditingController();
  RxList jsonSample = [].obs;

  getCheckinSO({
    BuildContext? context,
    void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();

    header['Content-Type'] = 'application/json';
    post['username'] = await LocalData.getData('user');
    API.basePost('/get-checkin-so.php', post, header, true, (result, error) {
      if(error != null){
        jsonSample.value = [{"Sales Order#": "-", "Tanggal": "-", "Barang": "-", "Notes": "?", "KG": "0", "Total": "0"}];
        nomorSo.text = "";
        callback!(null, error);
      }
      if(result != null){
        jsonSample.value = result['data'] as List;
        nomorSo.text = result['data'][0]['NO_BUKTI'].toString();
        callback!(result, null);
      }
    });
  }

  validationCheckInOut({BuildContext? context, void callback(result, exception)?}){
    if(nomorSo.text == ''){
      DialogConstant.alertError('Sales Order# tidak boleh kosong!');
    }else{
      checkInOut(
        context: context,
        callback: (result, error)=>callback!(result, error)
      );
    }
  }

  checkInOut({
    BuildContext? context,
    void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();

    header['Content-Type'] = 'application/json';
    post['nobukti'] = nomorSo.text;
    await LocalData.getData('user').then((user) {
      post['username'] = user;
    });
    post['tipe'] = tipe.value;
    post['lat'] = latitude.value;
    post['lng'] = longitude.value;
    post['foto'] = fotocheck.value;
    post['ttd'] = ttdcheck.value;

    DialogConstant.loading(context!, 'Proses...');

    API.basePost('/check-so.php', post, header, true, (result, error) {
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